import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_2/model/User.dart';
import 'package:flutter_firebase_2/services/database.dart';

class AppAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  dynamic _generateUserFromAuth(User? user){
    return user != null ?AppUser(uid: user.uid):null;
  }

  Stream<AppUser?> get user{
    return _auth.authStateChanges().map((user)=>_generateUserFromAuth(user));
  }


  Future signInAnon () async{                                            
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _generateUserFromAuth(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }


  Future CreateUserWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      DatabaseService(uid:user.user!.uid).updateUserBrews("New Brew Member", "0", 100);
      return user;
    }catch(e){
      return e.toString();
    }
  }


  Future loginUserWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      DatabaseService(uid:user.user!.uid).updateUserBrews("New Brew Member", "0", 100);
      return user;
    }catch(e){
      return e.toString();
    }
  }



  Future signOut () async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}