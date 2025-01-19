import 'package:exam_schedule_app/models/exam_schedule_model.dart';
import 'package:exam_schedule_app/screens/add_exam_schedule_screen.dart';
import 'package:exam_schedule_app/services/exam_schedule_service.dart';
import 'package:flutter/material.dart';


void main() {
    runApp(MaterialApp(
    title: 'Exam Schedule App',
    home: AddExamScreen(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExamScheduleScreen(),
    );
  }
}

class ExamScheduleScreen extends StatefulWidget {
  @override
  _ExamScheduleScreenState createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  late Future<List<ExamSchedule>> _examSchedules;

  @override
  void initState() {
    super.initState();
    _examSchedules = ExamScheduleService().getExamSchedules(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
      ),
      body: FutureBuilder<List<ExamSchedule>>(
        future: _examSchedules,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show a loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No exam schedules available.'));
          } else {
            final examSchedules = snapshot.data!;
            return ListView.builder(
              itemCount: examSchedules.length,
              itemBuilder: (context, index) {
                final exam = examSchedules[index];
                return ListTile(
                  title: Text(exam.examName),
                  subtitle: Text('${exam.dateTime} at ${exam.location}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
