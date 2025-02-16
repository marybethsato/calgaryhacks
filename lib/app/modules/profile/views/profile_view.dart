import 'package:calgaryhacks/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            const SizedBox(
              height: 20,
            ),
            _buildProfileSection(),
            _buildXPCard(),
            _buildWildlifeCollectionButtons(),
            _buildConservationImpact(),
            logout(),
            const SizedBox(
              height: 20,
            ),
            const Center(child: Text('V1.1.0'))
          ],
        ),
      ),
    );
  }

  /// 🔹 Custom AppBar
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 28),
            onPressed: () => Get.back(),
          ),
          const SizedBox(width: 10),
          const Text("Profile",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget logout() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green.shade900,
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Get.offAndToNamed(Routes.AUTH);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )),
      ),
    );
  }

  /// 🔹 Profile Section with Avatar & Name
  Widget _buildProfileSection() {
    return Center(
      child: Obx(
        () => Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green.shade300,
              backgroundImage:
                  NetworkImage(controller.authenticationController.photo.value),
            ),
            const SizedBox(height: 8),
            Text(controller.authenticationController.name.value,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(controller.authenticationController.email.value,
                style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// 🔹 XP Rank & Badges Earned Card
  Widget _buildXPCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 85,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("XP Rank", style: TextStyle(color: Colors.white70)),
                  Text("Gold",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 85,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Points', style: TextStyle(color: Colors.white70)),
                  Text("20",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 85,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Badges", style: TextStyle(color: Colors.white70)),
                  Text("24",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Wildlife Collection Buttons
  Widget _buildWildlifeCollectionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: _wildlifeButton("View Wildlife Collection"),
    );
  }

  /// 🔹 Wildlife Button Widget
  Widget _wildlifeButton(String title) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.WILDLIFE_COLLECTION);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: Size.infinite.width,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.yellow.shade100,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200, blurRadius: 6, spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Conservation Impact Stats with Gradient
  Widget _buildConservationImpact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Total Conservation Impact",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade300, Colors.green.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _impactStat("36", "Photos Taken")),
                    Expanded(child: _impactStat("7", "Rare Species Spotted")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _impactStat("1.4k", "KilometersTraveled")),
                    Expanded(child: _impactStat("5", "Unique Locations")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Individual Conservation Impact Stat
  Widget _impactStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  /// 🔹 Small Conservation Stat
  Widget _smallStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  /// 🔹 Bottom Navigation Bar with Camera Button
  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: const Icon(Icons.home, size: 28), onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.explore, size: 28), onPressed: () {}),
            const SizedBox(width: 48), // Space for the floating camera button
            IconButton(
                icon: const Icon(Icons.auto_awesome, size: 28),
                onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.leaderboard, size: 28),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green.shade700,
      onPressed: () {},
      child: const Icon(Icons.camera_alt, color: Colors.white),
    );
  }
}
