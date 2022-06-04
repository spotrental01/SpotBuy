import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotbuy/constants.dart';
import 'package:spotbuy/screens/Ads/ads_screen.dart';
import 'package:spotbuy/screens/About.dart';
import 'package:spotbuy/screens/Help.dart';
import 'package:spotbuy/screens/editprofile.dart';
import 'package:spotbuy/screens/languages.dart';
import 'package:spotbuy/screens/login_screen.dart';
import 'package:spotbuy/screens/notifications.dart';
import 'package:spotbuy/screens/helpandsupport.dart';
import 'package:share_plus/share_plus.dart';
import '../size_config.dart';

class navigationdrawer extends StatelessWidget {
  const navigationdrawer({Key? key}) : super(key: key);

  share(BuildContext context) {
    String message =
        "Hi, I'm using SpotBuy, for buying and selling automobiles and  it's services : https://play.google.com/store/apps/details?id=com.s19mobility.spotbuy";

    // RenderBox? box =context.findRenderObject() as RenderBox;

    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(message,
        subject: 'Description',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    final user = cUser().displayName;
    return Container(
      width: 260,
      child: Drawer(
        child: Material(
          color: const Color(0xff2E3C5D),
          child: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Positioned(
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Align(
                          alignment: Alignment.topRight,
                          // child: Icon(
                          //   Icons.close,
                          //   color: Colors.white,
                          //   size: 30,
                          // ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png'),
                          radius: 33.0,
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: (5.0),
                            ),
                            Text(
                              user!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const editprofile()),
                                );
                              },
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: (15.0),
                    ),
                    const Divider(
                      thickness: 1.0,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: (10.0),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/notification.png',
                              width: 50.0,
                              height: 40.0,
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const notifications()),
                                );
                              },
                              child: const Text(
                                'Notifications',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/adsIcon.png',
                              width: getProportionateScreenWidth(50.0),
                              height: getProportionateScreenHeight(40.0),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AdsScreen()),
                                );
                              },
                              child: const Text(
                                'Your Ads',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/languagesIcon.png',
                              width: 50.0,
                              height: 40.0,
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Languages()),
                                );
                              },
                              child: const Text(
                                'Language',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/shareIcon.png',
                              width: 50.0,
                              height: 40.0,
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            TextButton(
                              onPressed: () {
                                share(context);
                              },
                              child: const Text(
                                'Share App',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/helpIcon.png',
                              width: 50.0,
                              height: 40.0,
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HelpandSupport()),
                                );
                              },
                              child: const Text(
                                'Help & Support',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/logoutIcon.png',
                              width: 50.0,
                              height: 40.0,
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const loginScreen(),
                                    ),
                                    (route) => false);
                              },
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Help()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const About()));
        break;

      default:
        Navigator.pop(context);
        break;
    }
  }
}
