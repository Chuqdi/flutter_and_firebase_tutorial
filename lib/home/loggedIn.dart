import 'package:flutter/material.dart';
import 'package:flutter_firebase_2/data.dart';
import 'package:flutter_firebase_2/home/brew/main.dart';
import 'package:flutter_firebase_2/model/User.dart';
import 'package:flutter_firebase_2/services/auth.dart';
import 'package:flutter_firebase_2/services/database.dart';
import 'package:provider/provider.dart';

class LoggedIn extends StatefulWidget {
  LoggedIn({Key? key}) : super(key: key);

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  @override
  Widget build(BuildContext context) {
    Function showSettingsForm = (BuildContext context, AppUser? user) {
      final _formKey = GlobalKey<FormState>();
      List<String> sugarChoices = ["0", "1", "2", "3", "4"];

      String sugar = "0";
      String name = "";
      int strength = 100;

      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
          ),
          context: context,
          builder: (context) {
            return StreamBuilder(
              stream: DatabaseService(uid: user == null ? "hh" : user.uid)
                  .getUserBrew,
              builder: (context, snapshot) {
                print(snapshot.data);
                print(snapshot.data);
                print(snapshot.data);
                print(snapshot.data);

                return snapshot.hasData
                    ? SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Center(
                                    child: Text(
                                  "Create Brew",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.brown[400],
                                  ),
                                )),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: inputDecoration("Name"),
                                      onChanged: (value) {
                                        setState(() {
                                          name = value;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    DropdownButtonFormField(
                                      value: sugar,
                                      items: sugarChoices.map((sugarChoice) {
                                        return DropdownMenuItem(
                                          child: Text("$sugarChoice sugars"),
                                          value: sugarChoice,
                                        );
                                      }).toList(),
                                      onChanged: (value) => setState(() {
                                        sugar = value.toString();
                                      }),
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Slider(
                                      value: 100,
                                      min: 100,
                                      max: 900,
                                      divisions: 8,
                                      activeColor: Colors.brown[strength],
                                      inactiveColor: Colors.brown,
                                      onChanged: (value) {
                                        setState(() {
                                          strength = value.round();
                                        });
                                      },
                                    ),
                                    RaisedButton(
                                      child: Text(
                                        "Save Changes",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () async {
                                        // if (_formKey.currentState!.validate()) {}
                                        print(name);
                                        print(sugar);
                                      },
                                      color: Colors.brown[400],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Text("No data here");
              },
            );
          });
    };

    AppBar _appBar(BuildContext context, AppUser? user) => AppBar(
          backgroundColor: Colors.brown[400],
          title: Text(Data.appName),
          actions: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  RaisedButton(
                    onPressed: () async {
                      await AppAuth().signOut();
                    },
                    child: Row(
                      children: [Text("Log Out"), Icon(Icons.person)],
                    ),
                  ),
                  SizedBox(
                    width: 23.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      showSettingsForm(context, user);
                    },
                    child: Flexible(
                        child: Row(children: [
                      Text("Settings"),
                      Icon(Icons.settings)
                    ])),
                  )
                ],
              ),
            )
          ],
        );
    final AppUser? user = Provider.of<AppUser?>(context);

    return Scaffold(
      appBar: _appBar(context, user),
      body: Container(
        child: MainBrew(),
      ),
    );
  }
}
