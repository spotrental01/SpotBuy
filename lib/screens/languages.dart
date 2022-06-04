import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../size_config.dart';

class Languages extends StatelessWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/languagebg.png',
              fit: BoxFit.contain,
              height: 45,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xff2E3C5D),
                  ),
                )),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    child: const Text(
                      'ENGLISH',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(30.0),
                  ),
                  Container(
                    child: const Text(
                      ' HINDI ',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(30.0),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child: const Text(
                      'BENGALI',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(30.0),
                  ),
                  Container(
                    child: const Text(
                      ' TAMIL ',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(30.0),
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
