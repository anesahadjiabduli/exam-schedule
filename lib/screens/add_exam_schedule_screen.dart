import 'package:flutter/material.dart';
import '../services/exam_schedule_service.dart';

class AddExamScreen extends StatefulWidget {
  @override
  _AddExamScreenState createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _examNameController = TextEditingController();
  final _examLocationController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Exam Schedule"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _examNameController,
                decoration: InputDecoration(labelText: "Exam Name"),
                validator: (value) => value!.isEmpty ? "Enter exam name" : null,
              ),
              TextFormField(
                controller: _examLocationController,
                decoration: InputDecoration(labelText: "Location"),
                validator: (value) => value!.isEmpty ? "Enter location" : null,
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                child: Text(
                  _selectedDate == null
                      ? "Select Exam Date"
                      : "Selected: ${_selectedDate!.toLocal()}",
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && _selectedDate != null) {
                    final examName = _examNameController.text;
                    final examLocation = _examLocationController.text;

                    // Call the service function to add the schedule
                    await ExamScheduleService()
                        .addExamSchedule(examName, _selectedDate!, examLocation);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Exam schedule added!")),
                    );
                    Navigator.pop(context); // Go back to the previous screen
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all fields")),
                    );
                  }
                },
                child: Text("Add Schedule"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
