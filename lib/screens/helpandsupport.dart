import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../size_config.dart';
import 'About.dart';

class HelpandSupport extends StatelessWidget {
  const HelpandSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/HelpIconbg.png',
              fit: BoxFit.contain,
              height: 45,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Help & Support',
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xff2E3C5D),
                ),
              ),
            ),
          ],
        ), // You can add title here
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff2E3C5D)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: const Color(0xff2E3C5D),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/AboutUs.png',
                    width: 50.0,
                    height: 40.0,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const About()),
                      );
                    },
                    child: const Text(
                      'About Us',
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
                    'assets/images/PrivacyPolicy.png',
                    width: 50.0,
                    height: 40.0,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  TextButton(
                    onPressed: () async {
                      final url = 'https://www.spotbuy.co.in/privacy.html';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: true,
                          forceWebView: true,
                          enableJavaScript: true,
                        );
                      }
                    },
                    child: const Text(
                      'Privacy Policy',
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
                    'assets/images/tnc.png',
                    width: 50.0,
                    height: 40.0,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  TextButton(
                    onPressed: () async {
                      final url =
                          'https://www.spotbuy.co.in/term&condition.html';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: true,
                          forceWebView: true,
                          enableJavaScript: true,
                        );
                      }
                    },
                    child: const Text(
                      'Terms and Conditions',
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
        ),
      ),
    );
  }
}
