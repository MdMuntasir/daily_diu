
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class firebaseAuthService
{
  FirebaseAuth _auth = FirebaseAuth.instance;

  // create account
  Future<User?> signUpWithEmailAndPassword(String email, String pass) async
  {
    try
        {
          UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
          return credential.user;
        }
        catch (e)
        {
          log("Error!");
        }
        return null;
  }
  // login
  Future<User?> loginWithEmailAndPassword(String email, String pass) async
  {
    try
    {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return credential.user;
    }
    catch (e)
    {
      log("Error!");
    }
    return null;
  }

}