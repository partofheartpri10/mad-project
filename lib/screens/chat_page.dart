import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/shared/loading.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


  @override
  Widget build(BuildContext context) {
    final reference = FirebaseDatabase.instance.reference().child('chat');
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            StreamBuilder(
              stream: reference.onValue,
              builder: (context,AsyncSnapshot snap){
            if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
              Map<dynamic,dynamic> data = snap.data.snapshot.value;
              List item = [];
              data.forEach((key, value) =>item.add(value["message"].toString()));
              return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context,index){
                return Text(item[index]);
              });
            }else{
              return Loading();
            }
              },
            ),
            Align(
                // alignment: Alignment.bottomCenter,
                child:TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(icon: Icon(Icons.send),
                      onPressed: (){
                        print(textEditingController.text);
                      if(textEditingController.text.length > 0){
                         reference.push().set({
                          "ques": textEditingController.text,
                           "ans":""
                        });

                        setState(() {
                          textEditingController.text = "";
                        });
                      }
                    },)
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}