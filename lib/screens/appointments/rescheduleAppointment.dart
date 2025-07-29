// lib/screens/user/reschedule_appointment.dart
import 'package:blood_system/blocs/appointment/bloc.dart';
import 'package:blood_system/blocs/appointment/event.dart';
import 'package:blood_system/blocs/appointment/state.dart';
import 'package:blood_system/widgets/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RescheduleAppointmentScreen extends StatefulWidget {
  final Map<String, dynamic> appointment;

  const RescheduleAppointmentScreen({super.key, required this.appointment});

  @override
  State<RescheduleAppointmentScreen> createState() =>
      _RescheduleAppointmentScreenState();
}

class _RescheduleAppointmentScreenState
    extends State<RescheduleAppointmentScreen> {
  DateTime? selectedDate;
  String? selectedLocation;
  String? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    // Initialize with current appointment data
    final appointmentDate =
        widget.appointment['appointmentDate'] ?? widget.appointment['date'];
    selectedDate =
        appointmentDate is DateTime ? appointmentDate : DateTime.now();
    selectedLocation =
        widget.appointment['hospitalName'] ?? widget.appointment['location'];

    // Preselect the current appointment time
    final currentTime =
        widget.appointment['appointmentTime'] ?? widget.appointment['time'];
    selectedTimeSlot = currentTime;

    // Load hospitals when screen initializes
    context.read<AppointmentBloc>().add(const LoadHospitals());

    // Load time slots for current hospital and date
    if (selectedLocation != null && selectedDate != null) {
      context.read<AppointmentBloc>().add(
        LoadAvailableTimeSlots(
          hospitalName: selectedLocation!,
          date: selectedDate!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        // Handle success messages
        if (state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: Colors.green,
            ),
          );
        }

        // Handle error messages
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return MainNavigationWrapper(
          currentPage: '/rescheduleAppointment',
          pageTitle: 'Reschedule Appointment',
          backgroundColor: const Color(0xFFF8F9FA),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // Changed from max to min
                      children: [
                        _buildCurrentAppointmentCard(),
                        const SizedBox(height: 24),
                        _buildDateSelector(state),
                        const SizedBox(height: 24),
                        _buildLocationSelector(state),
                        const SizedBox(height: 24),
                        _buildTimeSlotSelector(state),
                        const SizedBox(height: 32),
                        _buildActionButtons(state),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrentAppointmentCard() {
    final appointmentDate =
        widget.appointment['appointmentDate'] ?? widget.appointment['date'];
    final displayDate =
        appointmentDate is DateTime ? appointmentDate : DateTime.now();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current appointment details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Date',
            DateFormat('EEEE, MMMM d, yyyy').format(displayDate),
          ),
          _buildDetailRow(
            'Time',
            widget.appointment['appointmentTime'] ??
                widget.appointment['time'] ??
                'Unknown Time',
          ),
          _buildDetailRow(
            'Location',
            widget.appointment['hospitalName'] ??
                widget.appointment['location'] ??
                'Unknown Hospital',
          ),
          _buildDetailRow('Type', 'Blood Donation'),
        ],
      ),
    );
  }

  Widget _buildDateSelector(AppointmentState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'New Date',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _selectDate(state),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? DateFormat('EEEE, MMMM d, yyyy').format(selectedDate!)
                        : 'Select date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          selectedDate != null
                              ? Colors.black87
                              : Colors.grey.shade600,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSelector(AppointmentState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Hospital',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap:
              state.isLoadingHospitals
                  ? null
                  : () => _showLocationSelector(state),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child:
                      state.isLoadingHospitals
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : Text(
                            selectedLocation ?? 'Select hospital',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  selectedLocation != null
                                      ? Colors.black87
                                      : Colors.grey.shade600,
                            ),
                          ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlotSelector(AppointmentState state) {
    if (state.isLoadingTimeSlots) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.availableTimeSlots.isEmpty &&
        selectedDate != null &&
        selectedLocation != null) {
      return _buildInfoBox('No available time slots for this date');
    }

    if (state.availableTimeSlots.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Available Time Slots',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _boxDecoration(),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  state.availableTimeSlots.map((timeSlot) {
                    final isSelected = selectedTimeSlot == timeSlot;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTimeSlot = timeSlot;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? const Color(0xFFD7263D)
                                  : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:
                                isSelected
                                    ? const Color(0xFFD7263D)
                                    : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          timeSlot,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      );
    }

    return _buildInfoBox('Please select hospital and date first');
  }

  Widget _buildInfoBox(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Text(
        message,
        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(AppointmentState state) {
    final originalDate =
        widget.appointment['appointmentDate'] ?? widget.appointment['date'];
    final originalLocation =
        widget.appointment['hospitalName'] ?? widget.appointment['location'];
    final originalTime =
        widget.appointment['appointmentTime'] ?? widget.appointment['time'];

    final bool hasChanges =
        selectedDate != originalDate ||
        selectedLocation != originalLocation ||
        selectedTimeSlot != originalTime;

    final bool canConfirm =
        hasChanges &&
        selectedDate != null &&
        selectedLocation != null &&
        selectedTimeSlot != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: canConfirm ? _rescheduleAppointment : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD7263D),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Confirm Reschedule',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _selectDate(AppointmentState state) async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
        selectedTimeSlot = null; // Reset time slot when date changes
      });

      // Load time slots for the new date
      if (selectedLocation != null) {
        context.read<AppointmentBloc>().add(
          LoadAvailableTimeSlots(hospitalName: selectedLocation!, date: date),
        );
      }
    }
  }

  // FIXED: Modal bottom sheet with proper scrolling and constraints
  void _showLocationSelector(AppointmentState state) {
    // Use hospitals from state if available, otherwise use static list
    final hospitalList =
        state.hospitals.isNotEmpty
            ? state.hospitals.map((h) => h.name).toList()
            : [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow custom height
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        // Get screen height and calculate maximum height for modal
        final screenHeight = MediaQuery.of(context).size.height;
        final maxHeight = screenHeight * 0.7; // Use 70% of screen height

        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
            minHeight: 200, // Minimum height
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Fixed header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Select Hospital',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Scrollable content
              Flexible(
                child:
                    hospitalList.isEmpty
                        ? const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'No hospitals available',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                        : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shrinkWrap: true,
                          itemCount: hospitalList.length,
                          separatorBuilder:
                              (context, index) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final hospitalName = hospitalList[index];
                            final isSelected = selectedLocation == hospitalName;

                            return ListTile(
                              title: Text(
                                hospitalName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing:
                                  isSelected
                                      ? const Icon(
                                        Icons.check,
                                        color: Color(0xFFD7263D),
                                      )
                                      : null,
                              onTap: () {
                                setState(() {
                                  selectedLocation = hospitalName;
                                  selectedTimeSlot =
                                      null; // Reset time slot when hospital changes
                                });
                                Navigator.pop(context);

                                // Load time slots for the new hospital
                                if (selectedDate != null) {
                                  context.read<AppointmentBloc>().add(
                                    LoadAvailableTimeSlots(
                                      hospitalName: hospitalName,
                                      date: selectedDate!,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
              ),
              // Safe area padding at bottom
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  void _rescheduleAppointment() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Appointment Rescheduled'),
            content: Text(
              'Your appointment has been successfully rescheduled to ${DateFormat('EEEE, MMMM d, yyyy').format(selectedDate!)} at $selectedTimeSlot in $selectedLocation.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/appointments');
                  // call update appointment event
                  context.read<AppointmentBloc>().add(
                    RescheduleAppointment(
                      appointmentId: widget.appointment['id'] ?? '',
                      newDate: selectedDate!,
                      newTime: selectedTimeSlot!,
                      hospitalName: selectedLocation!,
                      userId: widget.appointment['userId'] ?? '',
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
