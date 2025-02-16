import 'package:calgaryhacks/app/modules/home/views/home_view.dart';
import 'package:calgaryhacks/app/modules/leaderboards/views/leaderboards_view.dart';
import 'package:calgaryhacks/app/modules/map/views/map_view.dart';
import 'package:calgaryhacks/app/modules/profile/views/profile_view.dart';
import 'package:calgaryhacks/app/modules/scan/views/scan_view.dart';
import 'package:calgaryhacks/app/widgets/disclaimer_card.widget.dart';
import 'package:calgaryhacks/app/widgets/web_view.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({super.key});

  static final Color defaultActiveColor = Color(0xFF3B7D3E);

  static TextStyle textStyle = TextStyle(fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(
      () {
        Color? iconColor(int i) {
          if (i == controller.currentIndex.value) {
            return defaultActiveColor;
          } else {
            return null;
          }
        }

        return PersistentTabView(
            navBarHeight: 60,
            onTabChanged: (value) {
              controller.currentIndex.value = value;

              if (value == 2) {
                Get.dialog(
                    barrierDismissible: false,
                    barrierColor: Colors.transparent,
                    Center(child: DisclaimerCard()));
              }
            },
            tabs: [
              PersistentTabConfig(
                screen: const HomeView(),
                item: ItemConfig(
                    activeForegroundColor: Color(0xFF3B7D3E),
                    icon:
                        Image.asset("assets/nav/home.png", color: iconColor(0)),
                    title: "Home",
                    textStyle: textStyle),
              ),
              PersistentTabConfig(
                screen: const MapView(),
                item: ItemConfig(
                    activeForegroundColor: Color(0xFF3B7D3E),
                    icon: Image.asset("assets/nav/explore.png",
                        color: iconColor(1)),
                    title: "Explore",
                    textStyle: textStyle),
              ),
              PersistentTabConfig(
                onSelectedTabPressWhenNoScreensPushed: () {
                  controller.capture();
                },
                screen: const ScanView(),
                item: ItemConfig(
                    activeForegroundColor: Color(0xFF3B7D3E),
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    title: "",
                    textStyle: textStyle),
              ),
              PersistentTabConfig(
                screen: ChatBot(),
                item: ItemConfig(
                    icon: Image.asset("assets/nav/ai.png", color: iconColor(3)),
                    title: "AI",
                    activeForegroundColor: Color(0xFF3B7D3E),
                    textStyle: textStyle),
              ),
              PersistentTabConfig(
                screen: const LeaderboardsView(),
                item: ItemConfig(
                    activeForegroundColor: Color(0xFF3B7D3E),
                    icon: Image.asset("assets/nav/leaderboards.png",
                        color: iconColor(4)),
                    title: "Leaderboards",
                    textStyle: textStyle),
              ),
            ],
            navBarBuilder: (navBarConfig) => Style13BottomNavBar(
                  navBarConfig: navBarConfig,
                ));
      },
    ));
  }
}
