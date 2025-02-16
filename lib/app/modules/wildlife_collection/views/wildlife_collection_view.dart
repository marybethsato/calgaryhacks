import 'package:calgaryhacks/app/models/taxon.model.dart';
import 'package:calgaryhacks/app/modules/scan/controllers/scan_controller.dart';
import 'package:calgaryhacks/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wildlife_collection_controller.dart';

class WildlifeCollectionView extends GetView<WildlifeCollectionController> {
  const WildlifeCollectionView({super.key});
  static final List<Map<String, String>> wildlifeCollection = [
    {
      "name": "Lion",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg"
    },
    {
      "name": "Elephant",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/3/37/African_Bush_Elephant.jpg"
    },
    {
      "name": "Giraffe",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/9f/Giraffe_standing.jpg"
    },
    {
      "name": "Panda",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/0/0f/Grosser_Panda.JPG"
    },
    {
      "name": "Koala",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/4/49/Koala_climbing_tree.jpg"
    },
    {
      "name": "Tiger",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/5/56/Tiger.50.jpg"
    },
    {
      "name": "Panda",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/0/0f/Grosser_Panda.JPG"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(),
          _buildSearchBar(),
          _buildWildlifeGrid(),
        ],
      ),
    );
  }

  /// 🔹 Custom AppBar with Back Button
  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, size: 28),
            onPressed: () => Get.back(),
          ),
          SizedBox(width: 10),
          Text("Wildlife Collection",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  /// 🔹 Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search species",
          prefixIcon: Icon(Icons.search, color: Colors.black54),
          filled: true,
          fillColor: Colors.green.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  /// 🔹 Wildlife Grid Section
  Widget _buildWildlifeGrid() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade300, Colors.green.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.builder(
          itemCount: wildlifeCollection.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final animal = wildlifeCollection[index];
            return _wildlifeCard(animal["name"]!, animal["image"]!);
          },
        ),
      ),
    );
  }

  /// 🔹 Wildlife Card
  Widget _wildlifeCard(String name, String image) {
    return InkWell(
      onTap: () {
        ScanController scanController = Get.find<ScanController>();
        scanController.currentTaxon.value =
            TaxonModel(totalResults: 1, page: 1, perPage: 1, results: [
          Result(
              combinedScore: 1,
              visionScore: 1,
              taxon: Taxon(
                  defaultPhoto: DefaultPhoto(
                      id: 1, url: image, mediumUrl: image, squareUrl: image),
                  id: 1,
                  rank: '1',
                  name: name,
                  iconicTaxonName: name,
                  preferredCommonName: name))
        ]);
        Get.toNamed(Routes.SCAN_DETAILS);
      },
      child: Stack(
        children: [
          Container(
            height: Size.infinite.height,
            width: Size.infinite.width,
            foregroundDecoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(12),
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: image.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(image, height: 60, fit: BoxFit.cover))
                : SizedBox.shrink(),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                '2pts',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              )
            ],
          )),
        ],
      ),
    );
  }
}
