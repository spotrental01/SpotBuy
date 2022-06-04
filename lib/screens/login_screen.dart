import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spotbuy/constants.dart';
import 'package:spotbuy/main.dart';
import 'package:spotbuy/screens/components/bottomnavigationscreen.dart';
import 'package:spotbuy/screens/home_screen.dart';
import 'package:spotbuy/screens/profile.dart/profile_page.dart';

import '../size_config.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(AuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
          (route) => false);

      // if (authCredential.user != null) {
      //   // print('user');
      // if (cUser().displayName == 'null') {
      //   print('in login above double cots and null');
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => Profilepage()));
      // }
      // if (cUser().displayName == null) {
      //   print('in login above null');
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => Profilepage()));
      // }
      // if (cUser().displayName != '') {
      //   print('in login above tabs');
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => TabsPage()));
      // }
      //   } else {
      //     print('in login above profile');
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => TabsPage()));
      //   }
      // }

    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          height: 50,
        ),
        const Spotbuylogo(),
        const SizedBox(
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Log In',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  )),
              // Text(''),
              SizedBox(
                height: getProportionateScreenWidth(30),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,


                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,

                    hintText: " +91 | Phone Number",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 5,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              FlatButton(
                onPressed: () async {
                  setState(() {
                    showLoading = true;
                  });
                  await _auth.verifyPhoneNumber(
                    phoneNumber: '+91' + phoneController.text.trim(),
                    verificationCompleted: (phoneAuthCredential) async {
                      setState(() {
                        showLoading = false;
                      });
                    },
                    verificationFailed: (verificationFailed) async {
                      setState(() {
                        showLoading = false;
                      });
                      _scaffoldKey.currentState!.showSnackBar(
                          SnackBar(content: Text(verificationFailed.message!)));
                    },
                    codeSent: (verificationId, resendingToken) async {
                      setState(() {
                        showLoading = false;
                        currentState =
                            MobileVerificationState.SHOW_OTP_FORM_STATE;
                        this.verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationId) async {},
                  );
                },
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "SEND OTP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: const Color(0xff00c4cc),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          height: 50,
        ),
        const Spotbuylogo(),
        const SizedBox(
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Log In',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  )),
              // Text('                                                            '),
              SizedBox(
                height: getProportionateScreenWidth(30),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.black)),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: otpController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: "Enter OTP",
                    hintStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.only(
                      left: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              FlatButton(
                onPressed: () async {
                  AuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otpController.text);

                  signInWithPhoneAuthCredential(phoneAuthCredential);
                },
                child: const Text(
                  "VERIFY OTP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: const Color(0xff00c4cc),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              child: showLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : currentState ==
                          MobileVerificationState.SHOW_MOBILE_FORM_STATE
                      ? getMobileFormWidget(context)
                      : getOtpFormWidget(context),
              padding: const EdgeInsets.all(16),
            ),
            showLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Image(
                        image: currentState ==
                                MobileVerificationState.SHOW_MOBILE_FORM_STATE
                            ? const AssetImage('assets/images/login_page.png')
                            : const AssetImage("assets/images/login2.png"),
                      ),
                    ),
                  )
          ],
        ));
  }
}

class Spotbuylogo extends StatelessWidget {
  const Spotbuylogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage =
        const AssetImage('assets/images/spotbuy@1X _371.png');
    Image image = Image(image: assetImage);
    return Container(
      child: image,
    );
  }
}
