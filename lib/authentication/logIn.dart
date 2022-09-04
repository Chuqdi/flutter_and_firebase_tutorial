import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_2/data.dart';
import 'package:flutter_firebase_2/model/User.dart';
import 'package:flutter_firebase_2/services/auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final AppAuth _auth = AppAuth();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String email = "", password = "";

  final AppBar _appBar = AppBar(
    backgroundColor: Colors.brown[400],
    title: Text(Data.appName),
    actions: [
      RaisedButton(
        onPressed: () {},
        child: Row(
          children: [Text("Log In"), Icon(Icons.person)],
        ),
      )
    ],
  );

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        key: _scaffoldKey,
        appBar: _appBar,
        body: Container(
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  new Builder(builder: (BuildContext context) {
                    return Flexible(
                        child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: inputDecoration("Email"),
                          onChanged: (value) => setState(() => email = value),
                          validator: (value) =>
                              value!.isEmpty ? "Please enter your email" : null,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: inputDecoration("Password"),
                          onChanged: (value) =>
                              setState(() => password = value),
                          validator: (value) =>
                              value!.isEmpty ? "Please enter your email" : null,
                        ),
                        SizedBox(height: 3.0),
                        RaisedButton(
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              dynamic response =
                                  await _auth.loginUserWithEmailAndPassword(
                                      email, password);
                                      print(response);
                              if (response is! AppUser) {
                                var snackBar =
                                    SnackBar(content: Text(response.toString()));
                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                            }
                          },
                          color: Colors.brown[400],
                        )
                      ],
                    ));
                  })
                ],
              ),
            )));
  }
}