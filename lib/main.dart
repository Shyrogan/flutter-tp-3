import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/firebase_options.dart';
import 'package:tp3/models/auth.dart';
import 'package:tp3/models/quizz.dart';
import 'package:tp3/screens/home.dart';
import 'package:tp3/screens/sign_in.dart';
import 'package:tp3/screens/quizz_create.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const Squizzi());
}

class Squizzi extends StatelessWidget {
  const Squizzi({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthModel()),
        ChangeNotifierProvider(create: (context) => QuizzModel()),
      ],
      child: MaterialApp(
        title: 'Squizzi',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black38),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const Layout(widget: HomeScreen()),
          '/sign-in': (context) => const Layout(widget: SignInScreen()),
          '/quizz/create': (context) => const Layout(widget: QuizCreateScreen()),
        },
      )
    );
  }
}

class Layout extends StatelessWidget {
  final Widget? widget;

  const Layout({super.key, this.widget});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: const Text("Squizzi"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: !model.isLoggedIn ? [
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Sign-in'),
          ] : [
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          onTap: (i) {
            final n = Navigator.of(context);
            if (model.isLoggedIn) {
              switch (i) {
                case 0:
                  n.pushNamed('/');
                  break;
                case 1:
                  n.pushNamed('/profile');
                  break;
              }
            }
          },
        ),
        body: Center(
          child: this.widget,
        ),
      )
    );
  }
}
