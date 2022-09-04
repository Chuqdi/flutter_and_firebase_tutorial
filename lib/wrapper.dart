import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_2/authentication/auth.dart';
import 'package:flutter_firebase_2/authentication/logIn.dart';
import 'package:flutter_firebase_2/home/loggedIn.dart';
import 'package:provider/provider.dart';

import 'model/User.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppUser? user = Provider.of<AppUser?>(context);
    bool loggedIn = false;

    final _appBar = AppBar(
      title: Text("Fireabase and Flutter"),
      centerTitle: true,
      backgroundColor: Colors.brown[400],
    );

    return user == null ? Auth() : LoggedIn();
  }
}
