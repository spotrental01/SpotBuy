import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotbuy/constants.dart';
import 'package:spotbuy/models/vehicle_data_model.dart';
import 'package:spotbuy/provider/vehicle_provider.dart';
import 'package:spotbuy/screens/Ads/edit.dart';

import '../../size_config.dart';

class notifications extends StatelessWidget {
  const notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 0,
        backgroundColor: Color(0xff2E3C5D),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Notifications',
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
      body: Center(
        child: Container(
          child: const Text(
            'No Notification Avaliable',
            style: TextStyle(
              fontWeight: FontWeight.w100,
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
