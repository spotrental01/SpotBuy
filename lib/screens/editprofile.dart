import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotbuy/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class editprofile extends StatefulWidget {
  const editprofile({Key? key}) : super(key: key);

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {

  final picker = ImagePicker();
  var image = Image.asset('assets/images/upload.jpg');
  final number=cUser().phoneNumber;
  final email=cUser().email;
  final _auth=FirebaseAuth.instance;

  @override
  void initState(){
    super.initState();
    readData();
  }

  Map<String,dynamic> data={
    'email': '',
    'gender':'',
    'address':'',
  };

  void readData() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("users").doc(cUser().uid);

    documentReference.get().then((datasnapshot) {
      setState(() {
        data['email']=datasnapshot["email"] ?? '';
        data['gender']=datasnapshot["gender"] ?? '';
        data['address']=datasnapshot["address"] ?? '';
      });
    });
  }

  TextEditingController userController = TextEditingController(text: cUser().displayName);

  @override
  void dispose() {
    super.dispose();
    userController.dispose();
  }

  /*Future getImage() async {
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() async {
      image = (await picker.pickImage(source: ImageSource.gallery)) as Image;
    });
  }*/
  File? image1;
  Future getPhoto() async{
    final image1 =await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image1 == null) return;

    final imageTemporary =File(image1.path);
    setState(() {
      this.image1 = imageTemporary;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 0,
        backgroundColor: const Color(0xff2E3C5D),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Update Profile',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: getPhoto,
                child: CircleAvatar(
                  backgroundColor: const Color(0xff2E3C5D),
                  radius: 40.0,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                    radius: 38,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image:image1 == null
                            ? Image.asset("assets/images/upload.jpg").image
                            : Image.file(image1!).image,
                        )
                      ),
                        /*image1 == null
                        ? Image.asset("assets/images/upload.jpg")
                        : Image.file(image1!),*/
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black54,
                ),
              ),
              TextFormField(
                controller: userController,
                // initialValue: user,
                maxLength: 20,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 0,
                  ),
                ),
              ),
              const Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              TextFormField(
                // readOnly: true,
                initialValue: number,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.phone,
                  ),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              TextFormField(
                onChanged: (String newValue){
                  data['email']=newValue;
                },
                key: Key(data['email'].toString()),
                initialValue: data['email'].toString(),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.email,
                  ),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
              const Text(
                'Gender',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              TextFormField(
                onChanged: (String newValue){
                  data['gender']=newValue;
                },
                //key: Key(data['gender'].toString()),
                initialValue: data['gender'].toString(),
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.male,
                  ),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              TextFormField(
                onChanged: (String newValue){
                  data['address']=newValue;
                },
                initialValue: data['address'].toString(),
                /*key: Key(data['address'].toString()),*/
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.home,
                  ),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xff2E3C5D),
                    ),
                    child: TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: const Text('CANCEL', style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.green,
                    ),
                    child: TextButton(
                      onPressed: (){
                        print(data);
                        cUser().updateDisplayName(userController.text);
                        FirebaseFirestore.instance.collection('users').doc(cUser().uid).update(data);
                      },
                      child: const Text('UPDATE', style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
