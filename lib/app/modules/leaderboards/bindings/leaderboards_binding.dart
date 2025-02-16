import 'package:get/get.dart';

import '../controllers/leaderboards_controller.dart';

class LeaderboardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaderboardsController>(
      () => LeaderboardsController(),
    );
  }
}
