import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotbuy/constants.dart';

import '../../../size_config.dart';
import '../../../provider/categories_provider.dart';

class CustomCategoriesList extends StatelessWidget {
  const CustomCategoriesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoriesProvider>(context);
    // final categoryData = categoryProvider.items;
    return SizedBox(
        height: getProportionateScreenHeight(100),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('categories').orderBy("id").snapshots() ,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            var categoryData = snapshot.data!.docs;
            for(var index1=0;index1<categoryData.length;index1++)
            print('Categories ${categoryData[index1]['title']}');
            // print(data[0]['title']);
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryData.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(right: getProportionateScreenWidth(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(70),
                      width: getProportionateScreenWidth(70),
                      child: FloatingActionButton(
                        onPressed: () {
                          Provider.of<CategoriesProvider>(context,
                                  listen: false)
                              .changeSelectedCategory(
                                  categoryData[index]['id']);
                        },
                        backgroundColor: categoryData[index]['isSelected']
                            ? sbPrimaryColor
                            : Colors.white,
                        child: Image.network(categoryData[index]['image_path']),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    Text(
                      categoryData[index]['title'].toUpperCase(),
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(13),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
