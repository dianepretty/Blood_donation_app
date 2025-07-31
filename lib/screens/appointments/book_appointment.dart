import 'package:blood_system/blocs/appointment/bloc.dart';
import 'package:blood_system/blocs/appointment/event.dart';
import 'package:blood_system/blocs/appointment/state.dart';
import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:blood_system/widgets/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String userId;

  const BookAppointmentScreen({super.key, required this.userId});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  @override
  void initState() {
    super.initState();
    // Load hospitals when screen initializes
    context.read<AppointmentBloc>().add(const LoadHospitals());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        // Check if user is authenticated
        if (authState is! AuthAuthenticated) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Please login to book an appointment',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          );
        }

        // Use the existing AppointmentBloc from the widget tree (created in main)
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
              // Navigate back after successful booking
              if (state.successMessage!.contains('booked successfully')) {
                Future.delayed(const Duration(seconds: 1), () {
                  if (mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/appointments',
                      (route) => route.settings.name == '/home',
                    );
                  }
                });
              }
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
            return _buildBookingScreen(context, state, widget.userId);
          },
        );
      },
    );
  }

  Widget _buildBookingScreen(
    BuildContext context,
    AppointmentState state,
    String userId,
  ) {
    return MainNavigationWrapper(
      backgroundColor: const Color(0xFFF8F9FA),
      currentPage: '/bookAppointment',
      pageTitle: 'Book Appointment',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildHospitalSelector(state),
                    const SizedBox(height: 24),
                    _buildDateSelector(state),
                    const SizedBox(height: 24),
                    _buildTimeSlotSelector(state),
                    const SizedBox(height: 24),
                    const SizedBox(height: 32),
                    _buildActionButtons(state, userId),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
        color: Color(0xFFD7263D),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Book Appointment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHospitalSelector(AppointmentState state) {
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
                  : () => _showHospitalSelector(state),
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
                          ? Text(
                            state.selectedHospitalName ?? 'Select hospital',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  state.selectedHospitalName != null
                                      ? Colors.black87
                                      : Colors.grey.shade600,
                            ),
                          )
                          : Text(
                            state.selectedHospitalName ?? 'Select hospital',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  state.selectedHospitalName != null
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

  void _showHospitalSelector(AppointmentState state) {
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
                            final isSelected =
                                state.selectedHospitalName == hospitalName;

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
                                  context.read<AppointmentBloc>().add(
                                    SelectHospital(hospitalName: hospitalName),
                                  );
                                });
                                Navigator.pop(context);

                                // Load time slots for the new hospital
                                if (state.selectedDate != null) {
                                  context.read<AppointmentBloc>().add(
                                    LoadAvailableTimeSlots(
                                      hospitalName: hospitalName,
                                      date: state.selectedDate!,
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

  Widget _buildDateSelector(AppointmentState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date',
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
                    state.selectedDate != null
                        ? DateFormat(
                          'EEEE, MMMM d, yyyy',
                        ).format(state.selectedDate!)
                        : 'Select date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          state.selectedDate != null
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
        state.selectedDate != null &&
        state.selectedHospitalName != null) {
      return _buildInfoBox('No available time slots for this date');
    }

    if (state.availableTimeSlots.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Time Slots',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  state.availableTimeSlots.map((timeSlot) {
                    final isSelected = state.selectedTimeSlot == timeSlot;
                    return GestureDetector(
                      onTap: () {
                        context.read<AppointmentBloc>().add(
                          SelectTimeSlot(timeSlot),
                        );
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
          ],
        ),
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

  Widget _buildActionButtons(AppointmentState state, String userId) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed:
            state.canBookAppointment && !state.isBooking
                ? () => _bookAppointment(state, userId)
                : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD7263D),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child:
            state.isBooking
                ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                : const Text(
                  'Book Appointment',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', true),
          _buildNavItem(Icons.history, 'History', false),
          _buildNavItem(Icons.person, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? const Color(0xFFD7263D) : Colors.grey,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? const Color(0xFFD7263D) : Colors.grey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _selectDate(AppointmentState state) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (date != null) {
      context.read<AppointmentBloc>().add(SelectAppointmentDate(date));
    }
  }

  void _bookAppointment(AppointmentState state, String userId) {
    context.read<AppointmentBloc>().add(
      BookAppointment(
        userId: userId,
        hospitalName: state.selectedHospitalName!,
        appointmentDate: state.selectedDate!,
        appointmentTime: state.selectedTimeSlot!,
      ),
    );
  }
}
