import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_schedule_app/models/exam_schedule_model.dart';


class ExamScheduleService {
  Future<List<ExamSchedule>> getExamSchedules() async {
    try {
      // Fetch the data from Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('exam_schedules').get();

      // Convert Firestore documents into ExamSchedule objects
      return querySnapshot.docs.map((doc) {
        return ExamSchedule.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching exam schedules: $e");
      return [];
    }
  }

  addExamSchedule(String examName, DateTime dateTime, String examLocation) {}
}
