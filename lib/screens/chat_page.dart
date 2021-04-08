import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/modals/chat.dart';
import 'package:mad_project/shared/loading.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


  @override
  Widget build(BuildContext context) {
    final reference = FirebaseDatabase.instance.reference().child('chat');
    TextEditingController ques = TextEditingController();
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            StreamBuilder(
              stream: reference.onValue,
              builder: (context,AsyncSnapshot snap){
            if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
              Map<dynamic, dynamic> data = snap.data.snapshot.value;
              List<Chat>item = [];
              data.forEach((key, value) => item.add(Chat(ques: value["ques"],ans:value["ans"])));
              return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(12.0),
                      color: Colors.pink.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Ques.',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                ),
                                  ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    item[index].ques,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                               ),
                                    ),
                                )
                              ]
                            ),

                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      'Ans.',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),

                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    item[index].ans
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
         else{
              return Loading();
            }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child:TextFormField(
                    controller: ques,
                    decoration: InputDecoration(
                      hintText: "Type your queries",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      suffixIcon: IconButton(icon: Icon(Icons.send),
                        onPressed: (){
                          print(ques.text);
                        if(ques.text.length > 0){
                           reference.push().set({
                            "ques": ques.text,
                             "ans":""
                          });
                          setState(() {
                            ques.clear();
                          });
                        }
                      },)
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}