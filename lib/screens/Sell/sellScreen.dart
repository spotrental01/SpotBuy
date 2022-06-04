import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:spotbuy/models/categories_model.dart';
import 'package:spotbuy/models/vehicle_data_model.dart';
import 'package:spotbuy/provider/categories_provider.dart';
import 'package:spotbuy/provider/user_provider.dart';
import 'package:spotbuy/screens/components/bottomnavigationscreen.dart';
import 'package:spotbuy/screens/home_screen.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

import '../../constants.dart';
final number=cUser().phoneNumber;

class SellScreen extends StatelessWidget {
  const SellScreen({Key? key}) : super(key: key);
  _openpopup(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select Plan',
              style: TextStyle(
                fontFamily: 'SEGOEUI',
                fontWeight: FontWeight.bold,
                fontSize: 34,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.cancel,
              ),
            ),
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(204, 103, 7, 1)),
                onPressed: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '2',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                          fontFamily: 'SEGOEUI',
                          color: Colors.white),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Posts',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            fontFamily: 'SEGOEUI',
                            color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      '19 ₹',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                          fontFamily: 'SEGOEUI',
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(49, 97, 254, 1)),
                onPressed: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '5',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                          color: Colors.white),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        'Posts',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            fontFamily: 'SEGOEUI',
                            color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      '39 ₹',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                          fontFamily: 'SEGOEUI',
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(41, 171, 12, 1)),
                  onPressed: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        '7',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                            color: Colors.white),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: const Text(
                          'Posts',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              fontFamily: 'SEGOEUI',
                              color: Colors.white),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        '59 ₹',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                            fontFamily: 'SEGOEUI',
                            color: Colors.white),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var test = snapshot.data!.docs;
            for (var i in test) {
              var dummy = i.data() as Map<String, dynamic>;
              // print(dummy);
              if (dummy['uid'] == cUser().uid) {
                Provider.of<UserProvider>(context, listen: false)
                    .saveMaxSellCount(dummy['maxSellCount']);
              }
            }
            var sellCount = Provider.of<UserProvider>(context, listen: false)
                .getSellMaxCount;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sell",
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'SEGOEUI',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "$sellCount",
                            style: const TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Post Left',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'SEGOEUI',
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green[900]),
                              onPressed: () {
                                _openpopup(context);
                              },
                              child: const Text(
                                'Topup',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SEGOEUI',
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(child: Options()),
                ],
              ),
            );
          },
        ));
  }
}

class Options extends StatefulWidget {
  Options({Key? key, this.isEdit = false, this.docId, this.vehicleModel})
      : super(key: key);
  bool isEdit;
  String? docId;
  VehicleModel? vehicleModel;
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  File _userImageFile = File('');
  String url = '';
  bool isImageEmpty = true;
  bool isKmDrivenEmpty = true;
  bool isSellAmountEmpty = true;
  bool isDescriptionTextEmpty = true;
  bool isVehicleEmpty = true;
  bool isOwnerNoEmpty = true;
  bool isTransmissionEmpty=true;
  bool isFuelTypeEmpty = true;
  bool isTitleEmpty = true;
  bool isBrandEmpty = true;
  bool isModelEmpty = true;
  bool isCity = true;
  List<File> selectedFiles = [];
  List<String> savedUrl = [];

  void saveImages(List<File> dummy) async {
    var sellCount =
        Provider.of<UserProvider>(context, listen: false).getSellMaxCount;
    var counter = 1;
    for (var element in dummy) {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref()
          .child('${cUser().uid}/$sellCount/$counter.jpg')
          .putFile(element);
      counter++;
      if (snapshot.state == TaskState.success) {
        final String url = await snapshot.ref.getDownloadURL();
        savedUrl.add(url);
      }
    }
  }

  void _pickYear(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final Size size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Text('Select a Year'),
          // Changing default contentPadding to make the content looks better

          contentPadding: const EdgeInsets.all(10),
          content: SizedBox(
            // Giving some size to the dialog so the gridview know its bounds

            height: size.height / 3,
            width: size.width,
            //  Creating a grid view with 3 elements per line.
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                // Generating a list of 123 years starting from 2022
                // Change it depending on your needs.
                ...List.generate(
                  123,
                      (index) => InkWell(
                    onTap: () {
                      // The action you want to happen when you select the year below,
                      setState(() {
                        // dropdownmodelvalue = selected!.year.toString();
                      });
                      // Quitting the dialog through navigator.
                      Navigator.pop(context);
                    },
                    // This part is up to you, it's only ui elements
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        label: Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            // Showing the year text, it starts from 2022 and ends in 1900 (you can modify this as you like)
                            (2022 - index).toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> getAddressFromLatLong(Position loc) async {
    List<Placemark> dummy =
        await placemarkFromCoordinates(loc.latitude, loc.longitude);
    Placemark place = dummy[0];
    await FirebaseFirestore.instance
        .collection('places')
        .doc(place.locality)
        .set({
      'place': place.locality,
    });
    return place.locality!;
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
          .showSnackBar(const SnackBar(content: Text('Success')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void updateSellMaxCount() {
    Provider.of<UserProvider>(context, listen: false).decreaseMaxSellCount();
  }

  void savePost() async {
    var vi = widget.isEdit
        ? 0
        : Provider.of<CategoriesProvider>(context, listen: false)
            .getCatergoryId(dropdowncategoryvalue);
    Position position = await _determinePosition();
    String place = await getAddressFromLatLong(position);
    Map<String, dynamic> obj = {
      'image': savedUrl,
      'kmDriven': kmsController.text.trim(),
      'sellAmount': double.parse(priceController.text.trim()),
      'descriptionText': descriptionController.text.trim(),
      'vehicle': dropdownvehiclesvalue,
      'ownerNo': dropownervalue,
      'place': place,
      'fuelType': dropdownfueltypevalue,
      'title': dropdownbrandvalue + ' ' + dropdownvehiclesvalue,
      'vehicleType': dropdowncategoryvalue,
      'yearModel': dropdownmodelvalue + ' model',
      'vehicleId': vi,
      'itemBy': cUser().uid,
      'itemByName': cUser().displayName,
      'chache': '',
      'brand': dropdownbrandvalue,
      'postNo':
          Provider.of<UserProvider>(context, listen: false).getSellMaxCount,
    };
    if (widget.isEdit) {
      print('inside isEdit');
      Map<String, dynamic> edited = {
        isImageEmpty ? 'chache ' : 'image': savedUrl,
        isKmDrivenEmpty ? 'chache' : 'kmDriven': kmsController.text.trim(),
        isSellAmountEmpty ? 'chache' : 'sellAmount':
            double.parse(priceController.text.trim()),
        isDescriptionTextEmpty ? 'chache' : 'descriptionText':
            descriptionController.text.trim(),
        isVehicleEmpty ? 'chache' : 'vehicle': dropdownvehiclesvalue,
        isOwnerNoEmpty ? 'chache' : 'ownerNo': dropownervalue,
        isFuelTypeEmpty ? 'chache' : 'fuelType': dropdownfueltypevalue,
        isBrandEmpty || isModelEmpty ? 'chache' : 'title':
            dropdownbrandvalue + ' ' + dropdownmodelvalue,
        isModelEmpty ? 'cache' : 'yearModel': dropdownmodelvalue + ' model',
      };

      await FirebaseFirestore.instance
          .collection('vehicle_database')
          .doc(widget.docId)
          .update(
            edited,
          );
      Navigator.of(context).pop();
    } else {
      await FirebaseFirestore.instance.collection('vehicle_database').add(
            obj,
          );
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(selectedCategoryId)
          .set(selectedCategory);
      updateSellMaxCount();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => TabsPage(),
          ),
          (route) => false);
    }
    // save to category
  }

  TextEditingController kmsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String dropdownbrandvalue = '   Brand';
  List<String> brandItems = [];
  late Map<String, dynamic> selectedBrand;

  String dropdownmodelvalue = '   Model';

  List<String> vehicleItems = [];
  late Map<String, dynamic> selectedVehicle;
  String dropdownvehiclesvalue = '   Vehicles';

  String dropdowncategoryvalue = '   Category';
  List<String> categoryItems = [];
  late Map<String, dynamic> selectedCategory;
  late String selectedCategoryId;
  String dropdownfueltypevalue = '   FuelType';
  var fueltypeItems = [
    '   FuelType',
    '   Petrol',
    '   Diesel',
    '   Electric',
    '   CNG and Hybrid',
  ];
  String dropownervalue = '   Number Of Owners';
  var ownerItem = [
    '   Number Of Owners',
    '   1',
    '   2',
    '   3',
    '   4',
    '   4+',
  ];
  String transmissionvalue = '   Transmission Mode';
  var transmissiontypes = [
    '   Transmission Mode',
    '   Manual',
    '   Auto',
  ];
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
              child: widget.isEdit
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedFiles.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(
                          selectedFiles[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : (selectedFiles.isNotEmpty)
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedFiles.length,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Image.file(
                              selectedFiles[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.add_photo_alternate,
                          size: 35,
                        ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          //Category
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('all_category').orderBy("id").snapshots(),
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
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  underline: const SizedBox(),
                  isExpanded: true,
                  value: dropdowncategoryvalue,
                  items: categoryItems
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCategory = categoryData
                          .firstWhere((element) => element['title'] == value);
                      dropdowncategoryvalue = value!;
                      selectedCategoryId = categoryId.firstWhere(
                              (element) => element['title'] == value)['id'];
                    });
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),

          //Brand
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
                    });
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),

          //Vehicles
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
                      isVehicleEmpty = false;
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

          //FUEL TYPE
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

          // // model
          // GestureDetector(
          //   onTap: () async {
          //     final todayDate = DateTime.now();
          //     final selected = await showMonthYearPicker(
          //         context: context,
          //         initialDate: DateTime.now(),
          //         firstDate: DateTime(2008),
          //         lastDate: DateTime(2200));
          //     // print(selected!.year);
          //     setState(() {
          //       dropdownmodelvalue = selected!.year.toString();
          //       isModelEmpty = false;
          //     });
          //   },
          //   child: Container(
          //       height: 50,
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.black, width: 1),
          //       ),
          //       child: Row(
          //         children: [
          //           Text(dropdownmodelvalue),
          //           const Icon(Icons.arrow_drop_down)
          //         ],
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       )),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),

          // model
          GestureDetector(
            onTap: () async {
              _pickYear(context);
              // setState(() {
              //   dropdownmodelvalue = selected!.year.toString();
              // });
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

          //Number of owner
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

          //Transmission
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              value: transmissionvalue,
              items: transmissiontypes
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  isTransmissionEmpty = false;
                  transmissionvalue = value!;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          //KMS dialog
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black)),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (_) {
                setState(() {
                  isKmDrivenEmpty = false;
                });
              },
              controller: kmsController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 15),
                isDense: true,
                labelText: 'KMS Ridden',
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          //Description Box
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
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 15),
                labelText: 'Description',
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              maxLength: 150,
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          //Price

          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black)),
            child: TextField(
              keyboardType: TextInputType.phone,
              onChanged: (_) {
                setState(() {
                  isSellAmountEmpty = false;
                });
              },
              controller: priceController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: 15,
                ),
                labelText: 'Price',
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          //City

          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black)),
            child: TextField(
              onChanged: (_) {
                setState(() {
                  isCity = false;
                });
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: 15,
                ),
                labelText: 'City',
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),


          //Post Button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(41, 171, 12, 1)),
              onPressed: () {
                if (widget.isEdit) {
                  if (isSellAmountEmpty) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter Price')));
                  }
                  savePost();
                } else if (Provider.of<UserProvider>(context, listen: false)
                        .getSellMaxCount ==
                    0) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      scrollable: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select Plans',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                              fontFamily: 'SEGOEUI',
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.cancel,
                            ),
                          ),
                        ],
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange),
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    '2',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 34,
                                        fontFamily: 'SEGOEUI',
                                        color: Colors.white),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: const Text(
                                      'Posts',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                          fontFamily: 'SEGOEUI',
                                          color: Colors.white),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    '19 ₹',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 34,
                                        fontFamily: 'SEGOEUI',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[900]),
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    '5',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 34,
                                        fontFamily: 'SEGOEUI',
                                        color: Colors.white),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: const Text(
                                      'Posts',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'SEGOEUI',
                                          color: Colors.white),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    '39 ₹',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 34,
                                        fontFamily: 'SEGOEUI',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green[800]),
                                onPressed: () {},
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      '7',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 34,
                                          fontFamily: 'SEGOEUI',
                                          color: Colors.white),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: const Text(
                                        'Posts',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'SEGOEUI',
                                            color: Colors.white),
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      '59 ₹',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 34,
                                          fontFamily: 'SEGOEUI',
                                          color: Colors.white),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  if (isImageEmpty) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Select an Image')));
                  }
                  if (isBrandEmpty) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter Brand')));
                  }
                  if (isVehicleEmpty) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter vehicle')));
                  }
                  if (isModelEmpty) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter Model')));
                  }
                  if (isKmDrivenEmpty) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter Km Driven')));
                  }
                  if (isOwnerNoEmpty) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Enter Number of owners')));
                  }
                  if (isFuelTypeEmpty) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter Fuel type')));
                  }
                  if (isDescriptionTextEmpty) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter Description')));
                  }
                  if (isSellAmountEmpty) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter Price')));
                  }

                  savePost();
                }
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
