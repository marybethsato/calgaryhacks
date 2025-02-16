import 'package:get/get.dart';

import '../controllers/wildlife_collection_controller.dart';

class WildlifeCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WildlifeCollectionController>(
      () => WildlifeCollectionController(),
    );
  }
}
