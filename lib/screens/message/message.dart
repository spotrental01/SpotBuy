import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotbuy/screens/message/components/chat_screen.dart';
import 'package:spotbuy/screens/profile.dart/profile_page.dart';

import '../../constants.dart';
import '../../size_config.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return ChatScreen1(user: chats[0].sender);*/
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 0,
        backgroundColor: const Color(0xff2E3C5D),
        title: Row(
          children: [
            const SizedBox( width: 20.0),
            Image.asset(
              'assets/images/chats.png',
              width: 50.0,
              height: 40.0,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Chats',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          //Used this button to get into the chat screen as the database didnt have any users
          /*ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ChatScreen(
                      toId: "uid", name: "James"),
                ));
              },
              child: Text("James")),*/
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.75,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users/${cUser().uid}/chats')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  print('${cUser().displayName} ${cUser().uid}');
                  var data = snapshot.data!.docs
                      .where((element) => element['uid'] != cUser().uid)
                      .toList();
                  print(data.length);

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                toId: data[index]['uid'], name: data[index]['name']),
                          ));
                        },
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('chatRoom')
                              .doc(formatId(cUser().uid, data[index]['uid']))
                              .collection(formatId(cUser().uid, data[index]['uid']))
                              .orderBy('timeStamp', descending: true)
                              .snapshots(),
                          builder: (context, snapshot2) {
                            if (!snapshot2.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            var data2 = snapshot2.data!.docs.first;

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: getProportionateScreenWidth(20),
                                ),
                                ListTile(
                                  title: Text(
                                    data[index]['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 25),
                                  ),
                                  subtitle: Text(
                                    data2['message'],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                const Divider(
                                  height: 10,
                                  indent: 15,
                                  endIndent: 15,
                                  color: Colors.black,
                                ),
                              ],
                            );
                          },
                        )
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
