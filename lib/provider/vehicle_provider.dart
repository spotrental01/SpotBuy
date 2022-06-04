import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spotbuy/constants.dart';
import '../models/vehicle_data_model.dart';

class VehicleProvider with ChangeNotifier {
  final List<VehicleModel> _item = [
    // VehicleModel(
    //   vehicleId: 001,
    //   vehicleType: 'Car',
    //   image: 'assets/images/car1.png',
    //   title: 'HondaCity',
    //   yearModel: '2018 Model',
    //   ownerNo: '2',
    //   kmDriven: '60000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 580000,
    // ),
    // VehicleModel(
    //   vehicleId: 002,
    //   vehicleType: 'Bike',
    //   image: 'assets/images/bike1.png',
    //   title: 'Bajaj Discover',
    //   yearModel: '2016 Model',
    //   ownerNo: '1',
    //   kmDriven: '30000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 28000,
    // ),
    // VehicleModel(
    //   vehicleId: 003,
    //   vehicleType: 'Tractor',
    //   image: 'assets/images/Tractor(2).png',
    //   title: 'John Dheere 5045D',
    //   yearModel: '2019 Model',
    //   ownerNo: '1',
    //   kmDriven: '5000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 380000,
    // ),
    // VehicleModel(
    //   vehicleId: 004,
    //   vehicleType: 'Auto',
    //   image: 'assets/images/auto(1_.png',
    //   title: 'Bajaj Maxima Z',
    //   yearModel: '2016 Model',
    //   ownerNo: '2',
    //   kmDriven: '25000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 90000,
    // ),
    // VehicleModel(
    //   vehicleId: 005,
    //   vehicleType: 'Bus',
    //   image: 'assets/images/bus(1).png',
    //   title: 'Scania N230 UD',
    //   yearModel: '2014 Model',
    //   ownerNo: '3',
    //   kmDriven: '300000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 28000,
    // ),
    // VehicleModel(
    //   vehicleId: 002,
    //   vehicleType: 'Bike',
    //   image: 'assets/images/bike1.png',
    //   title: 'Bajaj Discover',
    //   yearModel: '2016 Model',
    //   ownerNo: '1',
    //   kmDriven: '30000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 28000,
    // ),
    // VehicleModel(
    //   vehicleId: 003,
    //   vehicleType: 'Tractor',
    //   image: 'assets/images/bike1.png',
    //   title: 'Bajaj Discover',
    //   yearModel: '2016 Model',
    //   ownerNo: '1',
    //   kmDriven: '30000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 28000,
    // ),
    // VehicleModel(
    //   vehicleId: 003,
    //   vehicleType: 'Tractor',
    //   image: 'assets/images/bike1.png',
    //   title: 'Bajaj Discover',
    //   yearModel: '2016 Model',
    //   ownerNo: '1',
    //   kmDriven: '30000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 28000,
    // ),
    // VehicleModel(
    //   vehicleId: 004,
    //   vehicleType: 'Auto',
    //   image: 'assets/images/bike1.png',
    //   title: 'Bajaj Discover',
    //   yearModel: '2016 Model',
    //   ownerNo: '1',
    //   kmDriven: '30000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 28000,
    // ),
    // VehicleModel(
    //   vehicleId: 004,
    //   vehicleType: 'Auto',
    //   image: 'assets/images/bike1.png',
    //   title: 'Bajaj Discover',
    //   yearModel: '2016 Model',
    //   ownerNo: '1',
    //   kmDriven: '30000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 28000,
    // ),
    // VehicleModel(
    //   vehicleId: 004,
    //   vehicleType: 'Auto',
    //   image: 'assets/images/bike1.png',
    //   title: 'Bajaj Discover',
    //   yearModel: '2016 Model',
    //   ownerNo: '1',
    //   kmDriven: '30000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 28000,
    // ),
    // VehicleModel(
    //   vehicleId: 005,
    //   vehicleType: 'Bus',
    //   image: 'assets/images/bike1.png',
    //   title: 'Bajaj Discover',
    //   yearModel: '2016 Model',
    //   ownerNo: '1',
    //   kmDriven: '30000',
    //   fuelType: 'Petrol',
    //   descriptionText:
    //       'The rain was coming. Everyone thought this would be a good thing. It hadn\'t rained in months and the earth was dry as a bone. It wasn\'t a surprise that everyone thought a good rain was what was needed',
    //   sellAmount: 28000,
    // ),
  ];
  void fetchAllVehicleData(List data) {
    List<VehicleModel> dummy = [];
    _item.clear();
    for (var element in data) {
      print(element['image'].length);
      dummy.add(VehicleModel(
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
          postNo: element['postNo'],
          vehicle: element['vehicle'],
          brand: element['brand'],
          itemByName: element['itemByName']));

      print(element['vehicleId']);
    }
    _item.addAll(dummy);

    // return [..._item];
  }

  List<VehicleModel> getVehicleById(int id) {
    List<VehicleModel> dummy = [];

    if (id == 0) return [..._item];

    for (var element in _item) {
      if (element.vehicleId == id) dummy.add(element);
    }
    return dummy;
  }

  Future saveData() async {
    try {
      List<Map<String, dynamic>> dummy = [];

      for (var e in _item) {
        dummy.add({
          'vehicleId': e.vehicleId,
          'vehicleType': e.vehicleType,
          'image': e.image,
          'title': e.title,
          'yearModel': e.yearModel,
          'ownerNo': e.ownerNo,
          'kmDriven': e.kmDriven,
          'fuelType': e.fuelType,
          'descriptionText': e.descriptionText,
          'sellAmount': e.sellAmount,
          'itemBy': cUser().uid,
        });
      }
      for (var e in dummy) {
        await FirebaseFirestore.instance.collection('vehicle_database').add(e);
        print('sucess');
      }
    } catch (e) {
      print('check');
      rethrow;
    }
  }
}
