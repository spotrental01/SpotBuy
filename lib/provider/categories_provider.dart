import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../models/categories_model.dart';

class CategoriesProvider with ChangeNotifier {
  final List<CategoriesModel> _items = [
    CategoriesModel(
      id: 0,
      image: '',
      name: 'All Vehicles',
      isSelected: true,
    ),
    CategoriesModel(
      id: 1,
      image: 'assets/images/car.png',
      name: 'Cycle',
      isSelected: false,
    ),
    CategoriesModel(
      id: 2,
      image: 'assets/images/bike.png',
      name: 'Bike',
      isSelected: false,
    ),
    CategoriesModel(
      id: 3,
      image: 'assets/images/tractor.png',
      name: 'Scooter',
      isSelected: false,
    ),
    CategoriesModel(
      id: 4,
      image: 'assets/images/auto.png',
      name: 'Car',
      isSelected: false,
    ),
    CategoriesModel(
      id: 5,
      image: 'assets/images/bus.png',
      name: 'E-Riksa',
      isSelected: false,
    ),
  ];

  List<CategoriesModel> get items {
    return [..._items];
  }

  void changeSelectedCategory(int id) {
    if (_items.firstWhere((element) => element.isSelected).id == id) id = 0;
    _items.firstWhere((element) => element.isSelected).isSelected = false;
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].id == id) _items[i].isSelected = !_items[i].isSelected;
    }
    notifyListeners();
  }

  int getCatergoryId(String name) {
    var dummy = _items.firstWhere((element) => element.name == name);
    return dummy.id;
  }

  CategoriesModel getSelectedCategory() {
    return _items.firstWhere((element) => element.isSelected);
  }
}
