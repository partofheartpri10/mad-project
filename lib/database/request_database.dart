import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mad_project/modals/request.dart';

class RequestDatabase{

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('request');

  Future updateRequest(Request req){
    DateTime dt = DateTime.now();
    collectionReference.doc(req.userUid+dt.toIso8601String()).set({
      "shopKeeperUid":req.shopKeeperUid,
      "userUid":req.userUid,
      "number":req.number,
      "amount":req.amount,
      "price":req.price,
      "accepted":req.accepted,
      "expectedTime":req.expectedTime
    });
  }

  List<Request>requestListFromSnap(QuerySnapshot snap){
    return snap.docs.map((e) {
      return Request(
          shopKeeperUid: e.data()["shopKeeperUid"],
          accepted: e.data()["accepted"],
          amount: e.data()["amount"],
          expectedTime: e.data()["expectedTime"],
          number: e.data()["number"],
          price: e.data()["price"],
          userUid: e.data()["userUid"]);
    }).toList();
  }

  Stream<List<Request>> get request {
    return collectionReference.snapshots()
        .map(requestListFromSnap);
  }

}