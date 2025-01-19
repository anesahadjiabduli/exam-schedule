import 'package:cloud_firestore/cloud_firestore.dart';

class ExamSchedule {
  final String examName;
  final DateTime dateTime;
  final String location;

  ExamSchedule({
    required this.examName,
    required this.dateTime,
    required this.location,
  });

  // Factory constructor to create an ExamSchedule object from a Firestore map
  factory ExamSchedule.fromMap(Map<String, dynamic> map) {
    return ExamSchedule(
      examName: map['examName'] as String,
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      location: map['location'] as String,
    );
  }
}
