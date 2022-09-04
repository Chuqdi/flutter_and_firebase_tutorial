import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_firebase_2/data.dart';
import 'package:flutter_firebase_2/model/Brew.dart';



class DatabaseService {


  static final  CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  final String uid;
  DatabaseService({ required this.uid });


  static List<Brew> _getBrewsFromSnapshot (QuerySnapshot snapshot){
    return snapshot.docs.map( (event){
      var d = event.data() as Map<String, dynamic>;
      return Brew(name: d['name'], sugar: d['sugar'], strength: d['strength']);
    }).toList();
  }


  Future updateUserBrews (String name, String sugar, int strength) async{
    brewCollection.doc(uid).set({
      "name":name,
      "sugar":sugar,
      "strength":strength
    });
  }

  static Stream<List<Brew>?> get getBrews {
    return brewCollection.snapshots().map(_getBrewsFromSnapshot);
  }

  Brew _getSingleBrew(DocumentSnapshot brewSnapshot){
    var d = brewSnapshot.data() as Map<String, dynamic>;
    return Brew(name: d['name'], sugar: d['sugar'], strength: d["strength"]);
  }

  Stream<Brew> get getUserBrew {
    return brewCollection.doc(this.uid).snapshots().map(_getSingleBrew);
  }

  
}