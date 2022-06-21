import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotbuy/models/user.dart';

class Message {
  late final User sender;
  late final String time; //Would usually be type DAteTime or Firebase Timestamp in production apps
  late final String text;
  late final bool unread;

  Message({
    required this.sender,
    required this.time,
    required this.text,
    required this.unread,
   });
}

 final User currentUser = User(
    name: 'Current User',
    id: 0,
    imageUrl: 'assets/images/user.png',
 );

 //USERS
 final User greg = User(
  name: 'Greg',
  id: 1,
   imageUrl: 'assets/images/user.png',
 );

 final User james = User(
  name: 'James',
  id: 2,
   imageUrl: 'assets/images/user.png',
 );

 final User john = User(
  name: 'John',
  id: 3,
   imageUrl: 'assets/images/user.png',
 );

final User sam = User(
  name: 'Sam',
  id: 4,
  imageUrl: 'assets/images/user.png',
);

 final User sophia = User(
  name: 'Sophia',
  id: 5,
   imageUrl: 'assets/images/user.png',
 );

 final User steven = User(
  name: 'Steven',
  id: 5,
   imageUrl: 'assets/images/user.png',
  );


 List<Message> chats =[
   Message(
       sender: james,
       time: '5:30',
       text: 'Hey how\'s it going? What did you do today?',
       unread: true
   ),
   Message(
       sender: john,
       time: '3:30 PM',
       text: 'Hey how\'s it going? What did you do today?',
       unread: false
   ),
   Message(
       sender: sophia,
       time: '2:30 PM',
       text: 'Hey how\'s it going? What did you do today?',
       unread: true
   ),
   Message(
       sender: steven,
       time: '1:30 PM',
       text: 'Hey how\'s it going? What did you do today?',
       unread: true
   ),
   Message(
       sender: greg,
       time: '11:30 AM',
       text: 'Hey how\'s it going? What did you do today?',
       unread: true
   ),
   Message(
       sender: sam,
       time: '12:30 PM',
       text: 'Hey how\'s it going? What did you do today?',
       unread: false
   )
 ];
List<Message> messages = [
  Message(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    unread: true,
  ),
  Message(
    sender: james,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    unread: true,
  ),
  Message(
    sender: james,
    time: '3:15 PM',
    text: 'All the food',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    unread: true,
  ),
  Message(
    sender: james,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    unread: true,
  ),
];

