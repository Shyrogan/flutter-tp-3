import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/models/auth.dart';
import 'package:tp3/models/quizz.dart';
import 'package:tp3/widgets/quizz_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(builder: (context, model, widget) => model.isLoggedIn ?
      Consumer<QuizzModel>(builder: (context, model, widget) {
        model.updateQuizzList();
        return Column(children: [
          ElevatedButton(child: const Text("Créer"), onPressed: () => Navigator.of(context).pushNamed('/quizz/create')),
          ...model.quizz.map((v) => QuizzCard(quizz: v))
        ]);
      }) :
      Card(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/sign-in'),
              child: const Text("Connexion")
            )
          ],
        )
      )
    );
  }
}
