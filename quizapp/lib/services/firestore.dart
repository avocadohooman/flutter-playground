import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((e) => e.data());
    var topics = data.map((e) => Topic.fromJson(e));

    return topics.toList();
  }

  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data() ?? {});
  }

  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection("reports").doc(user.uid);
        return ref.snapshots().map((event) => Report.fromJson(event.data()!));
      }
      return Stream.fromIterable([]);
    });
  }

  Future<void> updateUserReport(Quiz quiz) {
    var user = AuthService().user!;
    var ref = _db.collection("reports").doc(user.uid);

    var data = {
      "total": FieldValue.increment(1),
      "topics": {
        quiz.topic: FieldValue.arrayUnion([quiz.id]),
      }
    };
    return ref.set(data, SetOptions(merge: true));
  }
}