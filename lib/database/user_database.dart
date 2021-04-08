import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mad_project/modals/user.dart';
class UserDatabase{

  String uid;
  UserDatabase({this.uid});

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('user');

  Future updateUserData(AppUser user) async {
    return await collectionReference.doc(uid).set({
        "menstrualLength":user.menstrualLength,
        "periodLength":user.periodLength,
        "lastMenstruation":user.lastMenstruation.map((e) => e.toIso8601String()).toList(),
        "name":user.name
      }
    );
  }

  List<DateTime>dynamicToDateTime(List<dynamic>l){
    List<DateTime>res = List();
    for(String s in l)
      res.add(DateTime.parse(s));
    return res;
  }

  Stream<AppUser> get user {
    Stream<DocumentSnapshot> user = collectionReference.doc(uid).snapshots();
    return user.map((snapshot) {
      if(snapshot.exists==true && snapshot.data!=null)
      return AppUser(
          menstrualLength: snapshot.data()["menstrualLength"],
          periodLength: snapshot.data()["periodLength"],
          lastMenstruation:dynamicToDateTime( snapshot.data()["lastMenstruation"]),
          name: snapshot.data()["name"]
      );
      else {
        if(snapshot.exists == false){
          AppUser user = AppUser(menstrualLength: 0,periodLength: 0,lastMenstruation: [],name: "girl");
          updateUserData(user);
          return user;
        }else{
          return null;
        }
      }
    });
  }


}
