import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotbuy/constants.dart';

class UserProvider with ChangeNotifier {
  int sbMaxSellCount = 0;
  int get getSellMaxCount {
    return sbMaxSellCount;
  }

  void saveMaxSellCount(int sbmsc) {
    sbMaxSellCount = sbmsc;
    // notifyListeners();
  }

  void decreaseMaxSellCount() {
    sbMaxSellCount--;
    FirebaseFirestore.instance.collection('users').doc(cUser().uid).update({
      'maxSellCount': sbMaxSellCount,
    });
    notifyListeners();
  }


}
