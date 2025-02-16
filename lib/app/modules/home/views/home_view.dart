import 'package:calgaryhacks/app/models/taxon.model.dart';
import 'package:calgaryhacks/app/modules/scan/controllers/scan_controller.dart';
import 'package:calgaryhacks/app/routes/app_pages.dart';
import 'package:calgaryhacks/app/utils/strings.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: ListView(
          primary: false,
          children: [
            const SizedBox(
              height: 20,
            ),
            _buildAppBar(),
            _buildSearchBar(),
            _buildLocationAndStreaks(),
            _buildAnimalOfTheDay(),
            _buildDiscoverSpecies(),
            _buildClimateNews(),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 AppBar Section
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Catchy!", style: GoogleFonts.dynaPuff(fontSize: 28)),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
            child: Obx(
              () => CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(controller
                    .authenticationController
                    .photo
                    .value), // Change with real image
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search species",
          prefixIcon: const Icon(Icons.search, color: Colors.black54),
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

  /// 🔹 Location and Streaks Section
  Widget _buildLocationAndStreaks() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.green),
              Text(
                " Calgary",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Text("🔥 9 Streaks this week!", style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 Animal of the Day Section
  Widget _buildAnimalOfTheDay() {
    String image =
        "https://images.unsplash.com/photo-1717960848458-a3be6bc6a9b0?q=80&w=2739&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
    String name = "Canadian Goose";
    String scientificName = "Branta canadensis";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: () {
          ScanController scanController = Get.find<ScanController>();
          scanController.isFromCam.value = false;
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
        child: Column(
          children: [
            Text("Animal Of The Day",
                style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            const SizedBox(height: 12),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(image),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              scientificName,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// 🔹 Discover Species Nearby Section
  Widget _buildDiscoverSpecies() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Discover Species Nearby!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Column(
            children: [
              _speciesCard('Rabbit', 'Oryctolagus cuniculus',
                  'https://plus.unsplash.com/premium_photo-1661832480567-68a86cb46f34?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              const SizedBox(height: 10),
              _speciesCard('Chipmunk', 'Tamias',
                  'https://plus.unsplash.com/premium_photo-1674518553089-54b93d5c611f?q=80&w=2772&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  /// 🔹 Individual Species Card
  Widget _speciesCard(String name, String scientificName, String image) {
    return InkWell(
      onTap: () {
        ScanController scanController = Get.find<ScanController>();
        scanController.isFromCam.value = false;
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
      child: Card(
        color: Colors.green.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ))),
          title:
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(scientificName),
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade700),
        ),
      ),
    );
  }

  /// 🔹 Climate News Section
  Widget _buildClimateNews() {
    List<Map<String, dynamic>> news = [
      {
        "title":
            "Hurricane season is coming to an end. Here’s how to prepare for the next one, according to experts",
        "link":
            "https://www.cnn.com/cnn-underscored/home/hurricane-preparation-supplies?iid=cnn_buildContentRecirc_end_recirc",
        "image":
            "https://media.cnn.com/api/v1/images/stellar/prod/hurricaine-cnnu-alex-rennie.jpg"
      },
      {
        "title":
            "The world just marked a year above a critical climate limit scientists have warned about",
        "link":
            "https://www.cnn.com/2024/02/08/climate/global-warming-limit-climate-intl/index.html",
        "image":
            "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-1976101261.jpg"
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Climate News",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _newsCard(news[0])),
              const SizedBox(width: 10),
              Expanded(child: _newsCard(news[1]))
            ],
          )
        ],
      ),
    );
  }

  /// 🔹 Climate News Card
  Widget _newsCard(Map<String, dynamic> news) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(news['link']));
      },
      child: Column(
        children: [
          SizedBox(
            width: Size.infinite.width,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(news['image'], fit: BoxFit.cover),
            ),
          ),
          Text(news['title'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
