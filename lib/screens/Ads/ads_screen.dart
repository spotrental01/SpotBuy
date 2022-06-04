import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotbuy/constants.dart';
import 'package:spotbuy/models/vehicle_data_model.dart';
import 'package:spotbuy/provider/vehicle_provider.dart';
import 'package:spotbuy/screens/Ads/edit.dart';

import '../../size_config.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);
  void fetchData(List data, BuildContext context) {
    Provider.of<VehicleProvider>(context).fetchAllVehicleData(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 0,
        backgroundColor: Color(0xff2E3C5D),
        title: Row(
          children:[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Ads',
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('vehicle_database')
              .snapshots(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  child: const Text(
                    'No Ads Avaliable',
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
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Container(
                  child: const Text(
                    'No Ads Avaliable',
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
              );
            }
            var data = snapshot.data!.docs;

            List<VehicleModel> vehicleList = [];
            for (var ele in data) {
              var temp = ele.id;
              var element = ele.data()! as Map<String, dynamic>;
              if (element['itemBy'] == cUser().uid) {
                vehicleList.add(VehicleModel(
                  vehicleId: element['vehicleId'],
                  vehicleType: element['vehicleType'],
                  image: element['image'],
                  title: element['title'],
                  yearModel: element['yearModel'],
                  ownerNo: element['ownerNo'],
                  kmDriven: element['kmDriven'],
                  fuelType: element['fuelType'],
                  descriptionText: element['descriptionText'],
                  sellAmount: element['sellAmount'],
                  itemBy: element['itemBy'],
                  dbId: temp,
                  vehicle: element['vehicle'],
                  postNo: element['postNo'],
                  brand: element['brand'],
                  itemByName: element['itemByName'],
                ));
              }
            }
            // fetchData(data, context);

            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: vehicleList.length,
              itemBuilder: (context, index) => Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: vehicleList[index].image.length,
                          itemBuilder: (context, inde) => Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              vehicleList[index].image[inde],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              vehicleList[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenWidth(30),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditScreen(
                                  docId: vehicleList[index].dbId!,
                                  vehicleModel: vehicleList[index],
                                ),
                              ));
                            },
                            child: const Text('Edit'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        vehicleList[index].yearModel,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Chip(
                            backgroundColor: const Color(0xFFF5AAAA),
                            label: Text(
                              vehicleList[index].ownerNo + ' owner',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Chip(
                            backgroundColor: const Color(0xFFBAF4AA),
                            label: Text(
                              vehicleList[index].kmDriven + ' KM',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Chip(
                            backgroundColor: const Color(0xFFAAD2F5),
                            label: Text(
                              vehicleList[index].fuelType,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(20),
                        ),
                      ),
                      Text(
                        vehicleList[index].descriptionText,
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenWidth(10),
                      ),
                      Text(
                        '${vehicleList[index].sellAmount} \u{20B9}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
