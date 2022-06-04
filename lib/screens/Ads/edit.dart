import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:spotbuy/models/vehicle_data_model.dart';
import 'package:spotbuy/provider/categories_provider.dart';
import 'package:spotbuy/provider/user_provider.dart';
import 'package:spotbuy/screens/Sell/sellScreen.dart';

import '../../constants.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key, required this.docId, required this.vehicleModel})
      : super(key: key);
  final String docId;
  final VehicleModel vehicleModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Ads'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: EditOptions(
          docId: docId,
          vehicleModel: vehicleModel,
        ),
      ),
    );
  }
}

class EditOptions extends StatefulWidget {
  EditOptions({Key? key, this.docId, this.vehicleModel}) : super(key: key);
  String? docId;

  VehicleModel? vehicleModel;

  @override
  _EditOptionsState createState() => _EditOptionsState();
}

class _EditOptionsState extends State<EditOptions> {
  File _userImageFile = File('');
  String url = '';
  bool isImageEmpty = true;
  bool isKmDrivenEmpty = true;
  bool isSellAmountEmpty = true;
  bool isDescriptionTextEmpty = true;
  bool isvehicleEmpty = true;
  bool isOwnerNoEmpty = true;
  bool isFuelTypeEmpty = true;
  bool isTitleEmpty = true;
  bool isBrandEmpty = true;
  bool isModelEmpty = true;
  List<File> selectedFiles = [];
  List<dynamic> savedUrl = [];
  
  void saveImages(List<File> dummy) async {
    var sellCount =
        Provider.of<UserProvider>(context, listen: false).getSellMaxCount;
    var counter = 1;
    savedUrl.clear();
    for (var element in dummy) {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref()
          .child('${cUser().uid}/${widget.vehicleModel!.postNo}/$counter.jpg')
          .putFile(element);
      counter++;

      if (snapshot.state == TaskState.success) {
        final String url = await snapshot.ref.getDownloadURL();

        savedUrl.add(url);
      }
    }
  }

  _takeImageFromLibrary() async {
    try {
      var imageProvider = ImagePicker();
      var img = await imageProvider.pickMultiImage();
      // File _imageFieldFromLibrary = File(img!.path);
      // img!.forEach((element) async {
      // TaskSnapshot reference = await FirebaseStorage.instance
      //     .ref()
      //     .child("${cUser().uid}/${element.path}")
      //     .putFile(File(element.path));
      // if (reference.state == TaskState.success) {
      //   await reference.ref.getDownloadURL().then((value) {
      //     print(value);
      //     selectedFiles.add(value);
      //   });
      // }

      // });
      //Create a reference to the location you want to upload to in firebase
      List<File> dummy = [];
      img!.forEach((element) {
        dummy.add(File(element.path));
      });
      saveImages(dummy);
      setState(() {
        selectedFiles = dummy;
        isImageEmpty = false;
      });
      print(selectedFiles.length);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sucess')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void updateSellMaxCount() {
    Provider.of<UserProvider>(context, listen: false).decreaseMaxSellCount();
  }

  void savePost() async {
    var vi = Provider.of<CategoriesProvider>(context, listen: false)
        .getCatergoryId(dropdowncategoryvalue);

    print('inside isEdit');
    Map<String, dynamic> edited = {
      'image': savedUrl,
      'kmDriven': isKmDrivenEmpty ? kmHintText : kmsController.text.trim(),
      'sellAmount': isSellAmountEmpty
          ? priceText
          : double.parse(priceController.text.trim()),
      'descriptionText': isDescriptionTextEmpty
          ? descriptionText
          : descriptionController.text.trim(),
      'vehicle': dropdownvehiclesvalue,
      'ownerNo': dropownervalue,
      'fuelType': dropdownfueltypevalue,
      'title': dropdownbrandvalue + ' ' + dropdownvehiclesvalue,
      'yearModel': dropdownmodelvalue,
    };

    await FirebaseFirestore.instance
        .collection('vehicle_database')
        .doc(widget.docId)
        .update(
          edited,
        );
    Navigator.of(context).pop();
  }

  // save to category

  TextEditingController kmsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void setThings() {
    setState(() {
      dropdownbrandvalue = widget.vehicleModel!.brand;
      dropdownmodelvalue = widget.vehicleModel!.yearModel;
      dropdownvehiclesvalue = widget.vehicleModel!.vehicle;
      dropdowncategoryvalue = widget.vehicleModel!.vehicleType;
      dropdownfueltypevalue = widget.vehicleModel!.fuelType;
      dropownervalue = widget.vehicleModel!.ownerNo;
      kmHintText = widget.vehicleModel!.kmDriven;
      descriptionText = widget.vehicleModel!.descriptionText;
      priceText = widget.vehicleModel!.sellAmount;
      savedUrl = widget.vehicleModel!.image;
    });
  }

  String kmHintText = '';
  String descriptionText = '';
  double priceText = 0.0;

  String dropdownbrandvalue = '';
  String dropdownmodelvalue = '';
  String dropdownvehiclesvalue = '';
  String dropdowncategoryvalue = '';
  String dropdownfueltypevalue = '';

  String dropownervalue = '';

  List<String> brandItems = [];
  late Map<String, dynamic> selectedBrand;

  List<String> vehicleItems = [];
  late Map<String, dynamic> selectedVehicle;

  List<String> categoryItems = [];
  late Map<String, dynamic> selectedCategory;
  late String selectedCategoryId;
  var fueltypeItems = [
    '   FuelType',
    'Petrol',
    'Diseal',
  ];
  var ownerItem = [
    '   Number Of Owners',
    '1',
    '2',
    '3',
    '4+',
  ];
  @override
  void initState() {
    setThings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Images (Max 3)',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SEGOEUI',
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: _takeImageFromLibrary,
            child: Container(
                height: 200,
                width: double.maxFinite,
                color: Colors.grey[300],
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedFiles.isEmpty
                      ? widget.vehicleModel!.image.length
                      : selectedFiles.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width,
                    child: selectedFiles.isEmpty
                        ? Image.network(
                            widget.vehicleModel!.image[index],
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            selectedFiles[index],
                            fit: BoxFit.cover,
                          ),
                  ),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('info_vehicle')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.docs;
              // print(data[0]['allBrand']);
              brandItems.clear();

              brandItems.add('   Brand');
              var dummy = data[0]['allBrand'] as List;
              dummy.forEach((e) {
                brandItems.add(e.toString());
              });
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  underline: const SizedBox(),
                  isExpanded: true,
                  value: dropdownbrandvalue,
                  items: brandItems
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      isBrandEmpty = false;
                      dropdownbrandvalue = value!;
                      dropdownvehiclesvalue = '   Vehicles';
                    });
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('info_vehicle')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.docs;
              // print(data[0]['allBrand']);
              vehicleItems.clear();

              vehicleItems.add('   Vehicles');
              var temp = dropdownbrandvalue == '   Brand'
                  ? 'noBrand'
                  : dropdownbrandvalue;
              var dummy = data[1][temp] as List;
              dummy.forEach((e) {
                vehicleItems.add(e);
              });
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  underline: const SizedBox(),
                  isExpanded: true,
                  value: dropdownvehiclesvalue,
                  items: vehicleItems
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      isvehicleEmpty = false;
                      dropdownvehiclesvalue = value!;
                    });
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          // model
          GestureDetector(
            onTap: () async {
              final todayDate = DateTime.now();
              final selected = await showMonthYearPicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2008),
                  lastDate: DateTime(2200));
              // print(selected!.year);
              setState(() {
                dropdownmodelvalue = selected!.year.toString() + ' model';
              });
            },
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Row(
                  children: [
                    Text(dropdownmodelvalue),
                    const Icon(Icons.arrow_drop_down)
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              value: dropownervalue,
              items: ownerItem
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  isOwnerNoEmpty = false;
                  dropownervalue = value!;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              value: dropdownfueltypevalue,
              items: fueltypeItems
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  isFuelTypeEmpty = false;
                  dropdownfueltypevalue = value!;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('all_category')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var categoryList = snapshot.data!.docs;
              categoryItems = ['   Category'];
              var categoryData = [];
              var categoryId = [];
              for (var element in categoryList) {
                categoryData.add(element.data());
                categoryItems.add(element['title']);
                categoryId.add({'id': element.id, 'title': element['title']});
              }

              return GestureDetector(
                onTap: () async {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('You can not change the category')));
                },
                child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Row(
                      children: [
                        Text(dropdowncategoryvalue),
                        const Icon(Icons.arrow_drop_down)
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    )),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black)),
            child: TextField(
              onChanged: (_) {
                setState(() {
                  isKmDrivenEmpty = false;
                });
              },
              controller: kmsController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15, top: 10),
                isDense: true,
                hintText: kmHintText,
                hintStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            //height: 200,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black)),
            child: TextField(
              onChanged: (_) {
                setState(() {
                  isDescriptionTextEmpty = false;
                });
              },
              controller: descriptionController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15, top: 10),
                hintText: descriptionText,
                hintStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              maxLength: 300,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black)),
            child: TextField(
              onChanged: (_) {
                setState(() {
                  isSellAmountEmpty = false;
                });
              },
              controller: priceController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  left: 15,
                ),
                hintText: priceText.toString(),
                hintStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(41, 171, 12, 1)),
              onPressed: () {
                savePost();
              },
              child: const Text(
                'POST',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SEGOEUI',
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
