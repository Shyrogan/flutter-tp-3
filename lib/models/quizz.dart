import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Quizz {
  final String image;
  final String name;
  final List<Question> questions;
  
  const Quizz({
    this.image = "",
    required this.name,
    List<Question>? questions,
  }) : questions = questions ?? const [];

  Quizz.from(Map<String, dynamic> properties): this(
    name: properties['name'] as String,
    image: properties['image'] as String? ?? '',
    questions: (properties['questions'] as List<dynamic>?)
        ?.map((v) => Question.from(v as Map<String, dynamic>))
        .toList(growable: false) ?? const [],
  );
}

class Question {
  final String text;
  final bool isCorrect;
  
  const Question({
    required this.text,
    required this.isCorrect,
  });

  Question.from(Map<String, dynamic> properties): this(
    text: properties['text'] as String,
    isCorrect: properties['isCorrect'] as bool,
  );
}

class QuizzModel extends ChangeNotifier {
  List<Quizz> quizz = [];
  Quizz? currentQuizz;
  Question? currentQuestion;

  void updateQuizzList() {
    final quizz = FirebaseFirestore.instance.collection('quizz').get();
    quizz.then((v) {
      this.quizz = v.docs
        .map((doc) => Quizz.from(doc.data()))
        .toList(growable: false);
      notifyListeners();
    });
  }

  void startQuiz(Quizz quiz) {
    currentQuizz = quiz;
    currentQuestion = quiz.questions.isNotEmpty ? quiz.questions.first : null;
    notifyListeners();
  }
}
