import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotbuy/constants.dart';
import 'package:spotbuy/models/user.dart';
import 'package:spotbuy/screens/components/bottomnavigationscreen.dart';
import 'package:spotbuy/screens/profile.dart/Textfield_widget.dart';
import 'package:spotbuy/screens/profile.dart/user_preferances.dart';

import '../../size_config.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Stack(
      children: [
        const ProfileForm(),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            child: const Image(
              image: const AssetImage('assets/images/fill_details.png'),
            ),
          ),
        ),
      ],
    ));
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  TextEditingController controller1 = TextEditingController();

  TextEditingController controller2 = TextEditingController();

  void saveName(String name) async {
    await cUser().updateDisplayName(name);
    await FirebaseFirestore.instance.collection('users').doc(cUser().uid).set({
      'name': name,
      'uid': cUser().uid,
      'maxSellCount': 3,
    }).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => TabsPage(),
          ),
          (route) => false);
    }).catchError((_) {
      print('jjjjjjjjjjjjjjjj');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: (ListView(
          children: <Widget>[
            (const SizedBox(height: 130)),
            const Text(
              'Fill Details',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                  controller: controller1,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: 'First Name',
                    hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                    contentPadding: EdgeInsets.only(
                      left: 30,
                    ),
                  )),
            ),
            SizedBox(
              height: getProportionateScreenWidth(10),
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                controller: controller2,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: 'Last name',
                  hintStyle: TextStyle(fontSize: 18, color: Colors.black87),
                  contentPadding: EdgeInsets.only(
                    left: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            Row(
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.black)))),
                    onPressed: () {
                      saveName(controller1.text.trim() +
                          ' ' +
                          controller2.text.trim());
                    },
                    child: const Text('COMPLETE',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ))),
              ],
            )
          ],
        )),
      ),
    );
  }
}
