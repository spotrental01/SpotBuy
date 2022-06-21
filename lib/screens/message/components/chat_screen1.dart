import 'package:flutter/material.dart';
import 'package:spotbuy/size_config.dart';
import '../../../models/message_model.dart';
import '../../../models/user.dart';

class ChatScreen1 extends StatefulWidget {
  late final User user;
  DateTime t = DateTime.now();
  ChatScreen1({required this.user});
  @override
  _ChatScreen1State createState() => _ChatScreen1State();
}

class _ChatScreen1State extends State<ChatScreen1> {
  final ScrollController scrollcontroller = ScrollController();
  final TextEditingController controller = TextEditingController();

  _buildMessage(Message message,bool isMe){
    return Container(
      margin: isMe ?
      const EdgeInsets.only(
          top:8.0,
          bottom: 8.0,
          left: 80.0
      ) :
      const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          right: 80.0
      ),
      padding:EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
      child: Text(message.text),
      decoration: BoxDecoration(
          color: isMe ? Color(0xffd9e4ff):Colors.grey.shade50,
        borderRadius: isMe
            ?
        const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0)
        ):
        const BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0)
        )
      ),
    );
  }

  _buildMessageComposer(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xfff4f7fc),
              borderRadius: BorderRadius.circular(10)
            ),
            height: 50,
            width: 45,
            child: IconButton(icon: Icon(Icons.attach_file,color: Colors.blueGrey,),onPressed:(){} ,),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: "Type here...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
            ),
          ),
          IconButton(
            onPressed: (){
              DateTime t = DateTime.now();
              Message message =  Message(
                  sender: currentUser,
                  time: t.hour.toString() + ":" + t.minute.toString(),
                  text: controller.text,
                  unread: false
              );
              setState(() {
                messages.add(message);
                FocusScope.of(context).unfocus();
                scrollcontroller.jumpTo(scrollcontroller.position.maxScrollExtent);
                controller.clear();
              });
            },
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed:(){},icon:Icon(Icons.arrow_back_outlined)),
        backgroundColor: Colors.white,//const Color(0xff2E3C5D),
        title: Row(
          children: [
            CircleAvatar(radius:20,backgroundImage: AssetImage(widget.user.imageUrl),),
            const SizedBox(width: 12,),
            Text(
                widget.user.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                  controller: scrollcontroller,
                  padding: EdgeInsets.only(top: 15.0),
                    itemCount: messages.length,
                    itemBuilder:(BuildContext context,int index){
                    final Message message =messages[index];
                    final bool isMe =message.sender.id == currentUser.id;
                      return _buildMessage(message, isMe);
                    }
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
