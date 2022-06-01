import 'dart:convert';

import 'package:fimber_io/fimber_io.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:http/http.dart';
import 'package:intelligent_money_tracker_mobile/models/user_model.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final String _baseUri = 'http://34.118.9.214:7165';
  final String _resourceName = 'api/Users';
  late String userId;

  User? _userFromFire(auth.User? user) {
    if (user == null) {
      return null;
    }
    userId = user.uid;
    return User(id: user.uid, username: user.displayName);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFire);
  }

  Future<User?> _userFromFirebase(auth.User? user) async {
    if (user == null) {
      return null;
    }
    var userFromDb = await getUser(user.uid);
    return userFromDb;
  }

  Future<User> getUser(String id) async {
    try {
      var response = await get(Uri.parse('$_baseUri/$_resourceName/$id'));
      var decodedBody = jsonDecode(response.body);
      User user = User.fromJson(decodedBody);
      return user;
    } catch (ex, stackTrace) {
      Fimber.e('Unhandled exception', ex: ex, stacktrace: stackTrace);
      throw Exception('Failed to get user.');
    }
  }

  Future<User?> singInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // call backend api and return user entity from db
    return _userFromFirebase(credential.user);
  }

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
    String username,
    double sum,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    try {
      // call backend api and post user entity in db
      var response = await post(
        Uri.parse('$_baseUri/$_resourceName'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, Object?>{
            'id': credential.user?.uid,
            'username': username,
            'sum': sum
          },
        ),
      );
    } catch (ex, stackTrace) {
      Fimber.e('Unhandled exception', ex: ex, stacktrace: stackTrace);
      throw Exception('Failed to post user.');
    }
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
