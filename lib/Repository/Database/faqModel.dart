import 'package:cloud_firestore/cloud_firestore.dart';

class FaqModel {
  final String? id;
  final String questionNum;
  final String question;
  final String answer;
  final Timestamp time;

  const FaqModel({
    this.id,
    required this.questionNum,
    required this.question,
    required this.answer,
    required this.time,
  });

  toJson() {
    return {
      "questionNum": questionNum,
      "question": question,
      "answer": answer,
      "time": time,
    };
  }

  factory FaqModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return FaqModel(
      id: document.id,
      questionNum: data["questionNum"],
      question: data["question"],
      answer: data["answer"],
      time: data["time"],
    );
  }
}
