import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/modals/request.dart';
import 'package:provider/provider.dart';


class MyPlaceOrderPage extends StatefulWidget {
  @override
  _MyPlaceOrderPageState createState() => _MyPlaceOrderPageState();
}

class _MyPlaceOrderPageState extends State<MyPlaceOrderPage> {
  @override
  Widget build(BuildContext context) {

    List<Request>requests = Provider.of<List<Request>>(context)??[];
    List<Request>myRequests = [];
    User user = Provider.of<User>(context);
    List<String>brands = ["A","B","C","D","E","F"];

    for(Request req in requests){
      if(req.userUid == user.uid){
        myRequests.add(req);
      }
    }

    return Scaffold(
        body:ListView.builder(
            itemCount: myRequests.length,
            itemBuilder: (context,index){
          return ListTile(
            title: Text(myRequests[index].amount.toString()+" order to "+brands[myRequests[index].number],style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: myRequests[index].accepted==false?Text("Status : pending",style: TextStyle(color: Colors.red),):Text("Status : accepted arrives in ${myRequests[index].expectedTime} minutes",style: TextStyle(color: Colors.green)),
          );
        })
    );
  }
}
