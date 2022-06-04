import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotbuy/provider/categories_provider.dart';
import 'package:spotbuy/provider/vehicle_provider.dart';
import 'package:spotbuy/screens/About.dart';
import 'package:spotbuy/screens/navigation_drawer.dart';
import 'package:spotbuy/screens/drawer.dart';
import 'package:spotbuy/screens/help.dart';
import 'package:spotbuy/screens/profile.dart/profile_page.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String label = 'Place';
  void changeLabel() async {
    String dummy = await cUserLoc();
    setState(() {
      label = dummy;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeLabel();
    return Row(
      children: [
        FloatingActionButton(
          backgroundColor: Colors.white,
          splashColor: sbPrimaryColor,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          child: Icon(
            Icons.menu,
            size: getProportionateScreenWidth(25),
          ),
        ),

        const Spacer(),
        InkWell(
          onTap: () {
            Provider.of<CategoriesProvider>(context, listen: false);
          },
          child: Chip(
            elevation: 5,
            backgroundColor: Colors.grey[200],
            labelStyle: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold,
            ),
            label: Container(
              margin: EdgeInsets.all(getProportionateScreenWidth(5)),
              child: Text(
                label,
              ),
            ),
          ),
        )
      ],
    );
  }
}
