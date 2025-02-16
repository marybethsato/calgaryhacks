import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/leaderboards_controller.dart';

class LeaderboardsView extends GetView<LeaderboardsController> {
  const LeaderboardsView({super.key});
  @override
  static final List<Map<String, dynamic>> leaderboard = [
    {"rank": 1, "name": "Bryan Wolf", "points": 43},
    {"rank": 2, "name": "Meghan Jes...", "points": 40},
    {"rank": 3, "name": "Alex Turner", "points": 38},
    {"rank": 4, "name": "Marsha Fisher", "points": 36},
    {"rank": 5, "name": "Juanita Cormier", "points": 35},
    {"rank": 6, "name": "You", "points": 34},
    {"rank": 7, "name": "Tamara Schmidt", "points": 33},
    {"rank": 8, "name": "Ricardo Veum", "points": 32},
    {"rank": 9, "name": "Gary Sanford", "points": 31},
    {"rank": 10, "name": "Becky Bartell", "points": 30},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(),
          _buildTopThree(),
          _buildLeaderboardList(),
        ],
      ),
    );
  }

  /// 🔹 Custom AppBar with Back Button
  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text("Leaderboard",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }

  /// 🔹 Top 3 Leaderboard Section
  Widget _buildTopThree() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: leaderboard.sublist(0, 3).map((player) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircleAvatar(
                        radius: player["rank"] == 1 ? 40 : 35,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                    if (player["rank"] == 1)
                      Positioned(
                        top: -5,
                        child: Icon(Icons.emoji_events,
                            color: Colors.green, size: 28),
                      ),
                    Positioned(
                      bottom: -4,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.green.shade300,
                        child: Text("${player["rank"]}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(player["name"],
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${player["points"]} pts",
                    style: TextStyle(color: Colors.black54)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 🔹 Leaderboard List
  Widget _buildLeaderboardList() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: ListView.builder(
          itemCount: leaderboard.length - 3,
          itemBuilder: (context, index) {
            final player = leaderboard[index + 3];
            bool isCurrentUser = player["name"] == "You";
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isCurrentUser ? Colors.green.shade200 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  child: Icon(Icons.person),
                ),
                title: Text(
                  player["name"],
                  style: TextStyle(
                      fontWeight:
                          isCurrentUser ? FontWeight.bold : FontWeight.normal),
                ),
                subtitle: Text("${player["rank"]}"),
                trailing: Text(
                  "${player["points"]} pts",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
