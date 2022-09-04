import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_2/home/brew/singleBrew.dart';
import 'package:flutter_firebase_2/model/Brew.dart';
import 'package:provider/provider.dart';

class MainBrew extends StatefulWidget {
  const MainBrew({Key? key}) : super(key: key);

  @override
  State<MainBrew> createState() => _MainBrewState();
}

class _MainBrewState extends State<MainBrew> {
  @override
  Widget build(BuildContext context) {
    List<Brew>? brews = Provider.of<List<Brew>?>(context);
    

    return Container(
      child: ListView.builder(
        itemCount: brews == null ? 0 : brews.length ,
        itemBuilder: (context, index) => SingleBrew(brew: brews![index]),

        ),
    );
  }
}
