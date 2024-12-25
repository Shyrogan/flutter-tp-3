import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthModel extends ChangeNotifier {
  Error? error;

  AuthModel() {
    // Quand l'utilisateur change, on veut notifier tous les Widgets
    // qui dépendent de l'utilisateur.
    FirebaseAuth.instance.userChanges()
      .listen((user) => notifyListeners(), onError: (error) {
        notifyListeners();
        this.error = error;
      });
  }

  User? get user => FirebaseAuth.instance.currentUser;

  bool get isLoggedIn => user != null;
}
