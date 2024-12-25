import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        const Text("Connexion"),
        ElevatedButton(
          onPressed: () => FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider()),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text("Google"),
        ),
      ]),
    );
  }
}
