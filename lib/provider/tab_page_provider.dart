import 'package:flutter/material.dart';
import 'package:spotbuy/models/tabnavigation_model.dart';
import 'package:spotbuy/screens/Ads/ads_screen.dart';
import 'package:spotbuy/screens/home_screen.dart';
import 'package:spotbuy/screens/message/components/chat_screen.dart';
import 'package:spotbuy/screens/message/message.dart';
import 'package:spotbuy/screens/sell/sellScreen.dart';

class TabNavigationItemsData {
  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: const HomeScreen(),
          icon: const Icon(Icons.store_rounded),
          title: "Home",
        ),
        TabNavigationItem(
          page: const MessageScreen(),
          icon: const Icon(Icons.message),
          title: "Messages",
        ),
        TabNavigationItem(
          page: const AdsScreen(),
          icon: const Icon(Icons.widgets),
          title: "Ads",
        ),
        TabNavigationItem(
          page: const SellScreen(),
          icon: const Icon(Icons.sell),
          title: 'Sell',
        ),
      ];
}
