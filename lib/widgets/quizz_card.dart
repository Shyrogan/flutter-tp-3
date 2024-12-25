import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/models/quizz.dart';
import 'package:tp3/screens/quizz_answer.dart';

class QuizzCard extends StatelessWidget {
  final Quizz quizz;

  const QuizzCard({super.key, required this.quizz});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizzModel>(
      builder: (context, model, widget) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            if (quizz.image.isNotEmpty)
              Image.network(
                quizz.image,
                width: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.error),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
              ),
            Text(quizz.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold), maxLines: 2,),
            ElevatedButton(child: const Text("Démarrer"), onPressed: () {
              model.startQuiz(quizz);
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const QuizzPlayScreen()),
              );
            }),
          ])
        )
      )
    );
  }
}
