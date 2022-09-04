import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_2/model/Brew.dart';
import 'package:flutter_firebase_2/model/User.dart';
import 'package:flutter_firebase_2/services/auth.dart';
import 'package:flutter_firebase_2/services/database.dart';
import 'package:flutter_firebase_2/wrapper.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService.getBrews,
      initialData: null,
      child: StreamProvider<AppUser?>.value(
        value:AppAuth().user,
        initialData: null,
        child: MaterialApp(
          home: Home(),
        ),
      ),
    );
  }
}



class Home extends StatelessWidget{

  Widget build(BuildContext context){
    return Wrapper();
  }
}

