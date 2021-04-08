import 'package:flutter/material.dart';
import 'package:mad_project/database/request_database.dart';
import 'package:mad_project/modals/shopkeeper.dart';
import 'package:mad_project/screens/my_order_page.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {

    List<Shopkeeper> shopKeepers = Provider.of<List<Shopkeeper>>(context) ?? [];


    return Scaffold(
      appBar: AppBar(
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
                onPressed: (){},
              ),
            ),
          );
          }
      ),
    );
  }
}
