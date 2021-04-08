import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mad_project/modals/shopkeeper.dart';

class ShopkeeperDatabase{

  String uid;
  ShopkeeperDatabase({this.uid});

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('shopkeeper');

  Future updateShopkeeperDatabase(Shopkeeper shopkeeper)async{
    await collectionReference.doc(uid).set({
      "deliveryCharges":shopkeeper.deliveryCharges,
      "available":shopkeeper.available,
      "name":shopkeeper.name,
      "shopName":shopkeeper.shopName
    });
  }

  List<Shopkeeper>shopKeeperListFromSnapshot(QuerySnapshot snap){
    return snap.docs.map((e){
      return Shopkeeper(
          shopName: e.data()["shopName"],
          available: e.data()["available"]=="true",
          deliveryCharges: e.data()["deliveryCharge"],
          name: e.data()["name"]);
    }).toList();
  }

  Stream<List<Shopkeeper>> get shopkeepersList{
    return collectionReference.snapshots()
        .map(shopKeeperListFromSnapshot);
  }


  Stream<Shopkeeper> get shopkeeper {
    Stream<DocumentSnapshot> user = collectionReference.doc(uid).snapshots();
    return user.map((snapshot) {
      if (snapshot.exists == true && snapshot.data != null)
        return Shopkeeper(
            shopName: snapshot.data()["shopName"],
            available: snapshot.data()["available"],
            deliveryCharges: snapshot.data()["deliveryCharge"],
            name: snapshot.data()["name"]
        );
      else {
        if (snapshot.exists == false) {
          Shopkeeper user = Shopkeeper(
              name: "", available: false, deliveryCharges: 0, shopName: "");
          updateShopkeeperDatabase(user);
          return user;
        } else {
          return null;
        }
      }
    });
  }



}