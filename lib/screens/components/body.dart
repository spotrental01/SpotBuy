import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotbuy/screens/navigation_drawer.dart';

import 'custom_app_bar.dart';
import 'main_vehicle_list.dart';
import '../../../size_config.dart';
import 'custom_categories_list.dart';
import '../../../provider/categories_provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedCategory =
        Provider.of<CategoriesProvider>(context).getSelectedCategory();

    return Scaffold(
      drawer: navigationdrawer(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(
            getProportionateScreenWidth(10),
          ),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // customised app bar
                const CustomAppBar(),
                SizedBox(
                  height: getProportionateScreenWidth(10),
                ),

                // customised category list
                const CustomCategoriesList(),
                SizedBox(
                  height: getProportionateScreenWidth(10),
                ),

                // selected category text
                Text(
                  selectedCategory.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(30),
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(10),
                ),

                // main vehicle display list
                MainVehicleList(selectedCategory: selectedCategory),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
