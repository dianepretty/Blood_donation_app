import 'package:blood_system/blocs/event_bloc.dart';
import 'package:blood_system/blocs/event_event.dart';
import 'package:blood_system/blocs/event_state.dart';
import 'package:blood_system/models/event_model.dart';
import 'package:blood_system/widgets/red_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;
  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen>
    with TickerProviderStateMixin {
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  String? selectedStatus;
  DateTime? selectedDate;
  final List<String> statuses = ['active', 'upcoming', 'completed'];

  // Focus nodes for better form navigation
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _locationFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.event.name);
    locationController = TextEditingController(text: widget.event.location);
    descriptionController = TextEditingController(
      text: widget.event.description ?? '',
    );
    selectedStatus = widget.event.status;
    selectedDate = widget.event.date;

    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    // Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    _animationController.dispose();
    _titleFocusNode.dispose();
    _locationFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _pickDate() async {
    // Add haptic feedback
    HapticFeedback.lightImpact();

    final picked = await showDialog<DateTime>(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 16,
            child: Container(
              height: 420,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.grey[50]!],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD7263D).withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          color: const Color(0xFFD7263D),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Select Event Date',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SfDateRangePicker(
                      selectionMode: DateRangePickerSelectionMode.single,
                      initialSelectedDate: selectedDate,
                      selectionColor: const Color(0xFFD7263D),
                      todayHighlightColor: const Color(
                        0xFFD7263D,
                      ).withOpacity(0.3),
                      headerStyle: const DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      onSelectionChanged: (args) {
                        if (args.value is DateTime) {
                          Navigator.of(context).pop(args.value);
                        }
                      },
                      showActionButtons: true,
                      cancelText: 'Cancel',
                      confirmText: 'Select',
                      onCancel: () => Navigator.of(context).pop(),
                      onSubmit: (val) {
                        if (val is DateTime) {
                          Navigator.of(context).pop(val);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      HapticFeedback.selectionClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: RedHeader(
          title: "Edit Event",
          onBack: () => Navigator.of(context).pop(),
          showBack: true,
        ),
      ),
      body: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            Navigator.of(context).pop();
          } else if (state is EventError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header section with better visual hierarchy
                        _buildHeaderSection(),
                        const SizedBox(height: 32),

                        // Form fields with enhanced design
                        _buildFormField(
                          label: 'Title',
                          icon: Icons.event_rounded,
                          child: _buildTextField(
                            controller: titleController,
                            focusNode: _titleFocusNode,
                            hintText: 'Enter event title',
                            nextFocusNode: _locationFocusNode,
                          ),
                        ),

                        _buildFormField(
                          label: 'Date',
                          icon: Icons.calendar_today_rounded,
                          child: _buildDateSelector(),
                        ),

                        _buildFormField(
                          label: 'Location',
                          icon: Icons.location_on_rounded,
                          child: _buildTextField(
                            controller: locationController,
                            focusNode: _locationFocusNode,
                            hintText: 'Enter event location',
                            nextFocusNode: _descriptionFocusNode,
                          ),
                        ),

                        _buildFormField(
                          label: 'Description',
                          icon: Icons.description_rounded,
                          child: _buildTextField(
                            controller: descriptionController,
                            focusNode: _descriptionFocusNode,
                            hintText: 'Event description',
                          ),
                        ),

                        _buildFormField(
                          label: 'Status',
                          icon: Icons.info_rounded,
                          child: _buildDropdown(
                            value: selectedStatus,
                            items: statuses,
                            hint: 'Select event status',
                            onChanged: (value) {
                              setState(() {
                                selectedStatus = value;
                              });
                              HapticFeedback.selectionClick();
                            },
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Enhanced save button with BLoC state handling
                        BlocBuilder<EventBloc, EventState>(
                          builder: (context, state) {
                            final isLoading = state is EventOperationInProgress;
                            return _buildSaveButton(isLoading: isLoading);
                          },
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFD7263D).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.edit_rounded,
              color: Color(0xFFD7263D),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Event Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF1A1A1A),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Update your event information',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Row(
              children: [
                Icon(icon, size: 18, color: const Color(0xFFD7263D)),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction:
            nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        onSubmitted: (_) {
          if (nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFD7263D), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _pickDate,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? DateFormat('MMM d, yyyy').format(selectedDate!)
                        : 'Select event date',
                    style: TextStyle(
                      color:
                          selectedDate != null
                              ? const Color(0xFF1A1A1A)
                              : Colors.grey[500],
                      fontSize: 16,
                      fontWeight:
                          selectedDate != null
                              ? FontWeight.w500
                              : FontWeight.normal,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_month_rounded,
                  color: const Color(0xFFD7263D),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(
              hint,
              style: TextStyle(color: Colors.grey[500], fontSize: 16),
            ),
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFFD7263D),
              size: 24,
            ),
            style: const TextStyle(
              color: Color(0xFF1A1A1A),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            items:
                items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _getItemColor(item),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton({required bool isLoading}) {
    final isFormValid =
        titleController.text.isNotEmpty &&
        selectedDate != null &&
        locationController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        selectedStatus != null;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: (isFormValid && !isLoading) ? _handleSave : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  (isFormValid && !isLoading)
                      ? const Color(0xFFD7263D)
                      : Colors.grey[300],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
              disabledBackgroundColor: Colors.grey[300],
              disabledForegroundColor: Colors.grey[500],
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child:
                isLoading
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save_rounded,
                          size: 20,
                          color:
                              (isFormValid && !isLoading)
                                  ? Colors.white
                                  : Colors.grey[500],
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color:
                                (isFormValid && !isLoading)
                                    ? Colors.white
                                    : Colors.grey[500],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: isLoading ? Colors.grey : Colors.red,
            size: 28,
          ),
          tooltip: 'Delete Event',
          onPressed: isLoading ? null : _handleDelete,
        ),
      ],
    );
  }

  void _handleSave() {
    if (!_isFormValid()) return;

    HapticFeedback.mediumImpact();

    // Create updated event object
    final updatedEvent = Event(
      id: widget.event.id,
      name: titleController.text.trim(),
      location: locationController.text.trim(),
      date: selectedDate!,
      timeFrom: widget.event.timeFrom,
      timeTo: widget.event.timeTo,
      description: descriptionController.text.trim(),
      status: selectedStatus!,
      hospitalId: widget.event.hospitalId,
      adminId: widget.event.adminId,
    );

    // Dispatch update event to BLoC
    context.read<EventBloc>().add(UpdateEvent(updatedEvent));
  }

  void _handleDelete() {
    HapticFeedback.heavyImpact();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Delete Event',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            content: const Text(
              'Are you sure you want to delete this event? This action cannot be undone.',
              style: TextStyle(color: Color(0xFF666666), height: 1.4),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<EventBloc>().add(DeleteEvent(widget.event.id));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
    );
  }

  bool _isFormValid() {
    return titleController.text.trim().isNotEmpty &&
        selectedDate != null &&
        locationController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        selectedStatus != null;
  }

  Color _getItemColor(String item) {
    switch (item.toLowerCase()) {
      case 'medical':
      case 'active':
        return const Color(0xFF10B981);
      case 'community':
      case 'upcoming':
        return const Color(0xFF3B82F6);
      case 'social':
      case 'completed':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFFD7263D);
    }
  }
}
