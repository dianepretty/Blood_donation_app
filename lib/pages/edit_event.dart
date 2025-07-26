import 'package:blood_system/pages/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../widgets/red_header.dart';

class EditEventScreen extends StatefulWidget {
  final Map<String, dynamic> event;
  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen>
    with TickerProviderStateMixin {
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController attendeesController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  String? selectedType;
  String? selectedStatus;
  DateTime? selectedDate;
  final List<String> types = ['medical', 'community', 'social'];
  final List<String> statuses = ['active', 'upcoming', 'completed'];

  // Focus nodes for better form navigation
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _locationFocusNode = FocusNode();
  final FocusNode _attendeesFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.event['title']);
    locationController = TextEditingController(text: widget.event['location']);
    attendeesController = TextEditingController(
      text: widget.event['attendees'].toString(),
    );
    selectedType = widget.event['type'];
    selectedStatus = widget.event['status'];
    selectedDate = widget.event['date'];

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
    _animationController.dispose();
    _titleFocusNode.dispose();
    _locationFocusNode.dispose();
    _attendeesFocusNode.dispose();
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
      body: Column(
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
                          nextFocusNode: _attendeesFocusNode,
                        ),
                      ),

                      _buildFormField(
                        label: 'Type',
                        icon: Icons.category_rounded,
                        child: _buildDropdown(
                          value: selectedType,
                          items: types,
                          hint: 'Select event type',
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
                            });
                            HapticFeedback.selectionClick();
                          },
                        ),
                      ),

                      _buildFormField(
                        label: 'Attendees',
                        icon: Icons.people_rounded,
                        child: _buildTextField(
                          controller: attendeesController,
                          focusNode: _attendeesFocusNode,
                          hintText: 'Number of attendees',
                          keyboardType: TextInputType.number,
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

                      // Enhanced save button
                      _buildSaveButton(),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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

  Widget _buildSaveButton() {
    final isFormValid =
        titleController.text.isNotEmpty &&
        selectedDate != null &&
        locationController.text.isNotEmpty &&
        selectedType != null &&
        attendeesController.text.isNotEmpty &&
        selectedStatus != null;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: isFormValid ? _handleSave : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isFormValid ? const Color(0xFFD7263D) : Colors.grey[300],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
              disabledBackgroundColor: Colors.grey[300],
              disabledForegroundColor: Colors.grey[500],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.save_rounded,
                  size: 20,
                  color: isFormValid ? Colors.white : Colors.grey[500],
                ),
                const SizedBox(width: 12),
                Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isFormValid ? Colors.white : Colors.grey[500],
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red, size: 28),
          tooltip: 'Delete Event',
          onPressed: _handleDelete,
        ),
      ],
    );
  }

  Future<void> _handleSave() async {
    final docId = widget.event['id'];
    final eventData = {
      'name': titleController.text.trim(),
      'type': selectedType,
      'location': locationController.text.trim(),
      'date': selectedDate,
      'timeFrom': '', // Add time fields if needed
      'timeTo': '',
      'description': attendeesController.text.trim(), // Use correct field if needed
      'attendees': int.tryParse(attendeesController.text.trim()) ?? 0,
      'status': selectedStatus,
    };
    await FirebaseFirestore.instance.collection('events').doc(docId).update(eventData);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _handleDelete() async {
    final docId = widget.event['id'];
    await FirebaseFirestore.instance.collection('events').doc(docId).delete();
    if (mounted) Navigator.of(context).pop();
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
