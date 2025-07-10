import 'package:blood/pages/events.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class EditEventScreen extends StatefulWidget {
  final Map<String, dynamic> event;
  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController attendeesController;
  String? selectedType;
  String? selectedStatus;
  DateTime? selectedDate;
  final List<String> types = ['medical', 'community', 'social'];
  final List<String> statuses = ['active', 'upcoming', 'completed'];

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
  }

  void _pickDate() async {
    final picked = await showDialog<DateTime>(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: SizedBox(
              height: 400,
              child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.single,
                initialSelectedDate: selectedDate,
                onSelectionChanged: (args) {
                  if (args.value is DateTime) {
                    Navigator.of(context).pop(args.value);
                  }
                },
                showActionButtons: true,
                onCancel: () => Navigator.of(context).pop(),
                onSubmit: (val) {
                  if (val is DateTime) {
                    Navigator.of(context).pop(val);
                  }
                },
              ),
            ),
          ),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          RedHeader(
            title: 'Edit Event',
            onBack: () => Navigator.of(context).pop(),
            showBack: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Event details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF343A40),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF343A40),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Event title',
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF343A40),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                selectedDate != null
                                    ? DateFormat(
                                      'MMM d, yyyy',
                                    ).format(selectedDate!)
                                    : 'Select date',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF343A40),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: 'Event location',
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF343A40),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedType,
                          hint: const Text(
                            'Select type',
                            style: TextStyle(color: Colors.grey),
                          ),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.black54,
                          ),
                          items:
                              types.map((type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Attendees',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF343A40),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: attendeesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Number of attendees',
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF343A40),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedStatus,
                          hint: const Text(
                            'Select status',
                            style: TextStyle(color: Colors.grey),
                          ),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.black54,
                          ),
                          items:
                              statuses.map((status) {
                                return DropdownMenuItem<String>(
                                  value: status,
                                  child: Text(status),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed:
                            (titleController.text.isNotEmpty &&
                                    selectedDate != null &&
                                    locationController.text.isNotEmpty &&
                                    selectedType != null &&
                                    attendeesController.text.isNotEmpty &&
                                    selectedStatus != null)
                                ? () {
                                  // Handle save
                                }
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD7263D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
