
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

    for(Request req in requests){
      if(req.userUid == user.uid){
        myRequests.add(req);
      }
    }

    return Scaffold(body:  Container());
  }
}
