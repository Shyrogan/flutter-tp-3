import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/models/quizz.dart';

class QuizzPlayScreen extends StatelessWidget {
 const QuizzPlayScreen({super.key});

 @override
 Widget build(BuildContext context) {
   return Consumer<QuizzModel>(
     builder: (context, model, child) {
       if (model.currentQuizz == null) {
         return const Center(child: Text('Aucun quizz en cours.'));
       }

       final quiz = model.currentQuizz!;
       final currentQuestion = model.currentQuestion;
       final questionIndex = currentQuestion != null ? 
         quiz.questions.indexOf(currentQuestion) : -1;

       return Scaffold(
         appBar: AppBar(
           title: Text(quiz.name),
           actions: [
             Text('${questionIndex + 1}/${quiz.questions.length}'),
             const SizedBox(width: 16),
           ],
         ),
         body: Padding(
           padding: const EdgeInsets.all(16),
           child: Column(
             children: [
               if (quiz.image.isNotEmpty)
                 Image.network(
                   quiz.image,
                   height: 200,
                   width: double.infinity,
                   fit: BoxFit.cover,
                 ),
               const SizedBox(height: 24),
               if (currentQuestion != null) ...[
                 Text(
                   currentQuestion.text,
                   style: Theme.of(context).textTheme.headlineSmall,
                   textAlign: TextAlign.center,
                 ),
                 const Spacer(),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     ElevatedButton(
                       onPressed: () => _answerQuestion(context, model, false),
                       child: const Text('False'),
                     ),
                     ElevatedButton(
                       onPressed: () => _answerQuestion(context, model, true),
                       child: const Text('True'),
                     ),
                   ],
                 ),
                 const SizedBox(height: 32),
               ],
             ],
           ),
         ),
       );
     },
   );
 }

 void _answerQuestion(BuildContext context, QuizzModel model, bool answer) {
   final currentQuestion = model.currentQuestion;
   if (currentQuestion == null) return;

   final isCorrect = currentQuestion.isCorrect == answer;
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
       content: Text(isCorrect ? 'Correcte !' : 'Mauvaise réponse !'),
       backgroundColor: isCorrect ? Colors.green : Colors.red,
     ),
   );

   // Move to next question after delay
   Future.delayed(const Duration(seconds: 1), () {
     final nextIndex = model.currentQuizz!.questions.indexOf(currentQuestion) + 1;
     if (nextIndex < model.currentQuizz!.questions.length) {
       model.currentQuestion = model.currentQuizz!.questions[nextIndex];
     } else {
       // ignore: use_build_context_synchronously
       Navigator.of(context).pop(); // Quiz completed
     }
   });
 }
}
