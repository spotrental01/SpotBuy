import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'size_config.dart';

const sbPrimaryColor = Color(0xFF00C5CD);
const sbPrimaryLightColor = Color(0xFFb3fcff);

const sbSecondaryColor = Color(0xFF979797);
const sbTextColor = Colors.black87;

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp sbEmailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String sbEmailNullError = "Please Enter your email";
const String sbInvalidEmailError = "Please Enter Valid Email";
const String sbPassNullError = "Please Enter your password";
const String sbShortPassError = "Password is too short";
const String sbMatchPassError = "Passwords don't match";
const String sbNamelNullError = "Please Enter your name";
const String sbPhoneNumberNullError = "Please Enter your phone number";
const String sbAddressNullError = "Please Enter your address";

Future<Position> determinePosition() async {
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

Future<String> cUserLoc() async {
  Position loc = await determinePosition();
  return getAddressFromLatLong(loc);
}

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: sbTextColor),
  );
}

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    if (diff.inHours > 0) {
      time = diff.inHours.toString() + 'h ago';
    } else if (diff.inMinutes > 0) {
      time = diff.inMinutes.toString() + 'm ago';
    } else if (diff.inSeconds > 0) {
      time = 'now';
    } else if (diff.inMilliseconds > 0) {
      time = 'now';
    } else if (diff.inMicroseconds > 0) {
      time = 'now';
    } else {
      time = 'now';
    }
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    time = diff.inDays.toString() + 'd ago';
  } else if (diff.inDays > 6) {
    time = (diff.inDays / 7).floor().toString() + 'w ago';
  } else if (diff.inDays > 29) {
    time = (diff.inDays / 30).floor().toString() + 'm ago';
  } else if (diff.inDays > 365) {
    time = '${date.month}-${date.day}-${date.year}';
  }
  return time;
}

User cUser() {
  return FirebaseAuth.instance.currentUser!;
}

String formatId(String id1, String id2) {
  String trial = id1.toLowerCase() + id2.toLowerCase();
  var data = trial.split('');
  data.sort((a, b) {
    return a.toLowerCase().compareTo(b.toLowerCase());
  });
  return data.join('');
}
