import 'package:flutter/material.dart';
import 'package:chatapplication/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class ChatScreen extends StatefulWidget {

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String? messageText;
  var _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = _auth.currentUser;
    if(user!=null){
      loggedInUser = user;
      print(loggedInUser!.email);
    }
  }
  
  void getMessages() async{


    final messages = await _firestore.collection('messages').get();
    print("Got inside");
    for(var m in messages.docs){
      print(m.data());
    }

    
  }

  void getMessageStream() async{

    await for (var snapshot in _firestore.collection('messages').snapshots()){
      for (var message in snapshot.docs){
        print(message.data()['text']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                 print("Pressed");
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('💬 Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ShowMessages(loggedInUser!.email),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                      style: TextStyle(color: Colors.black),

                    ),
                  ),
                  TextButton(
                    onPressed: () {

                      _firestore.collection('messages').add({
                        'text' : messageText,
                        'sender': loggedInUser!.email,
                      });
                      _controller.clear();
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ShowMessages extends StatelessWidget {
 // const ShowMessages({Key? key}) : super(key: key);

  ShowMessages(this.mail);

  final String? mail;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('messages').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Expanded (
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical:2.0),
              reverse: true,
              shrinkWrap: true,
              primary: true,
              itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,i){
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return Container (
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(12),
                      //   border: Border.all(
                      //     color: Colors.black12,
                      //     width : 8.0,
                      //   ),
                      // ),

                      child: MessageTile(sender: x['sender'], text: x['text'], isMe: mail==x['sender']),
                      

                      // child: ListTile(
                      //   title: Text(x['text'], style: TextStyle(color: Colors.black)),
                      //   subtitle: Text(x['sender'],style: TextStyle(color: Colors.grey)),
                      //   dense: true,
                      // ),
                    ),
                  );
                }



            ),
          );
        }
    );
  }
}

class MessageTile extends StatelessWidget {
  //const MessageTile({Key? key}) : super(key: key);
  MessageTile({this.sender, this.text, this.isMe});

  final String? sender;
  final String? text;
  final bool? isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget> [
          Text(
            "$sender",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          Material(
            borderRadius: isMe! ? BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ) : BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),

            elevation: 5.0,
            color: isMe! ? Colors.lightBlueAccent : Colors.purpleAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                "$text",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),


    );
  }
}



