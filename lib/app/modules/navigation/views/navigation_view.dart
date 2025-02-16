import 'package:calgaryhacks/app/modules/home/views/home_view.dart';
import 'package:calgaryhacks/app/modules/map/views/map_view.dart';
import 'package:calgaryhacks/app/modules/profile/views/profile_view.dart';
import 'package:calgaryhacks/app/modules/scan/views/scan_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(
            tabs: [
          PersistentTabConfig(
            screen: const HomeView(),
            item: ItemConfig(
              icon: const Icon(Icons.home),
              title: "Home",
            ),
          ),
          PersistentTabConfig(
            screen: const MapView(),
            item: ItemConfig(
              icon: const Icon(Icons.message),
              title: "Map",
            ),
          ),
          PersistentTabConfig(
            screen: const ScanView(),
            item: ItemConfig(
              icon: const Icon(Icons.camera, color: Colors.white,),
              title: "Scan",
            ),
          ),
          PersistentTabConfig(
            screen: Container(),
            item: ItemConfig(
              icon: const Icon(Icons.settings),
              title: "Leaderboards",
            ),
          ),
          PersistentTabConfig(
            screen: const ProfileView(),
            item: ItemConfig(
              icon: const Icon(Icons.person),
              title: "Profile",
            ),
          ),
        ],
            navBarBuilder: (navBarConfig) => Style13BottomNavBar(
                  navBarConfig: navBarConfig,
                )));
  }
}
