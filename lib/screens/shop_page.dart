import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mad_project/database/request_database.dart';
import 'package:mad_project/modals/request.dart';
import 'package:mad_project/modals/shopkeeper.dart';
import 'package:mad_project/screens/my_order_page.dart';
import 'package:provider/provider.dart';


class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  int type=0;
  int total = 0;
  int amount=0;


  @override
  Widget build(BuildContext context) {

    List<Shopkeeper> shopKeepers = Provider.of<List<Shopkeeper>>(context) ?? [];
    User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Text("Shop"),
        actions:[ IconButton(icon: Icon(Icons.shopping_cart_outlined),onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>StreamProvider.value(value:RequestDatabase().request,child: MyPlaceOrderPage(),initialData: null,),));
        } ,)]
      ),
      body: ListView.builder(
        itemCount: shopKeepers.length,
          itemBuilder: (_,index){
          return Card(
            child: ListTile(
              title: Text(shopKeepers[index].shopName),
              subtitle: Text(shopKeepers[index].name),
              enabled: !shopKeepers[index].available,
              trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart_rounded),
                onPressed: (){
                  if(shopKeepers[index].available==false){
                    Fluttertoast.showToast(msg: "shopkeeper is not available");
                  }
                  else
                  showModalBottomSheet(
                      context: context, builder:(_){
                    return BottomSheet(
                      onClosing: (){},
                      builder:(context) {
                        return SingleChildScrollView(
                         physics: ScrollPhysics(),
                          child: Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return "please enter your name";
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          hintText: "name",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                  5.0)
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return "please enter address";
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.home),
                                          hintText: "address",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                  5.0)
                                          )
                                      ),
                                    ),
                                ),
  
                                         MaterialButton(
                            color: Colors.purpleAccent,
                                    onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Request req = Request(
                                          userUid: user.uid,
                                          shopKeeperUid: shopKeepers[index].uid,
                                          price: total,
                                          number: type,
                                          accepted: false,
                                          expectedTime: 0,
                                          amount: amount);
                                      RequestDatabase().updateRequest(req);
                                      Navigator.pop(context);
                                    }
                                  }, child: Text("place order"),)
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    );
         });
                },
              ),
            ),
          );
          }
      ),
    );
  }

}
