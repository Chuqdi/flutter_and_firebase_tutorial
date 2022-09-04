import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../model/Brew.dart';

class SingleBrew extends StatefulWidget {
  final Brew brew;
  SingleBrew({required this.brew});

  @override
  State<SingleBrew> createState() => _SingleBrewState();
}

class _SingleBrewState extends State<SingleBrew> {
  @override
  Widget build(BuildContext context) {
    var brew = widget.brew;
    return Container(
        child: Card(
      margin: EdgeInsets.all(20.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.brown[brew.strength],
          radius: 30.0,
        ),
        title: Text(brew.name),
        subtitle: Text("Takes ${brew.sugar} sugars"),
      ),
    ));
  }
}
