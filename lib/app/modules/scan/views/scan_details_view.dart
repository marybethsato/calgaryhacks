import 'package:calgaryhacks/app/models/climate_change.model.dart';
import 'package:calgaryhacks/app/models/observation.model.dart';
import 'package:calgaryhacks/app/models/taxon.model.dart';
import 'package:calgaryhacks/app/modules/scan/controllers/scan_controller.dart';
import 'package:calgaryhacks/app/providers/inaturalist_api.provider.dart';
import 'package:calgaryhacks/app/providers/iucn_api.provider.dart';
import 'package:calgaryhacks/app/routes/app_pages.dart';
import 'package:calgaryhacks/app/widgets/maps.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ScanDetailsView extends GetView<ScanController> {
  const ScanDetailsView({super.key});

  Taxon? get taxon {
    return controller.currentTaxon.value?.results.first.taxon;
  }

  String? get image {
    return taxon?.defaultPhoto.mediumUrl;
  }

  String? get title {
    return taxon?.name;
  }

  String? get commonName {
    return taxon?.preferredCommonName;
  }

  String? get scientificName {
    return taxon?.iconicTaxonName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: UniqueKey(),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.grey.shade200,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                child: image != null
                    ? Image.network(
                        image!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator())),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CloseButton(
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.4 - 20,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                )),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      commonName ?? "Common Name Here",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      title ?? "Name ",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                    Text(
                      scientificName ?? "Scientific Name",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.green.shade800),
                    ),
                    // 📝 Wikipedia Description

                    FutureBuilder<String?>(
                      future:
                          INaturalistAPI.getWikipediaDescription(title ?? ''),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return Text("No Wikipedia description available.");
                        }

                        String fullText = snapshot.data!;
                        bool isExpanded = false;

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  fullText,
                                  maxLines: isExpanded
                                      ? null
                                      : 5, // Show 5 lines initially
                                  overflow: isExpanded
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                ),
                                if (fullText != "No description found.")
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isExpanded =
                                                !isExpanded; // Toggle expansion state
                                          });
                                        },
                                        child: Text(isExpanded
                                            ? "Show Less"
                                            : "Show More"),
                                      ),
                                    ],
                                  ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    if (title != null)
                      FutureBuilder<ClimateChangeImpacts?>(
                        future:
                            ClimateChangeImpactProvider.getClimateChangeImpact(
                                title!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError ||
                              snapshot.data == null) {
                            return SizedBox();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Effects of Climate Change",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: snapshot.data!.threats
                                    .map((obs) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 4),
                                          child: Text("• " + obs.toString()),
                                        ))
                                    .toList(),
                              ),
                              SizedBox(height: 20),

                              // 🌱 Conservation Actions
                              Text("Conservation Actions",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 20),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ExpansionTile(
                                      title: const Text('Individual Actions',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: snapshot.data!
                                              .humanSolutions.individualActions
                                              .map((obs) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4),
                                                    child: Text(
                                                        " • " + obs.toString()),
                                                  ))
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                    ExpansionTile(
                                      title: const Text('Community Initiatives',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: snapshot
                                              .data!
                                              .humanSolutions
                                              .communityInitiatives
                                              .map((obs) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4),
                                                    child: Text(
                                                        " • " + obs.toString()),
                                                  ))
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                    ExpansionTile(
                                      title: const Text('Policy Legislation',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: snapshot.data!
                                              .humanSolutions.policyLegislation
                                              .map((obs) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4),
                                                    child: Text(
                                                        " • " + obs.toString()),
                                                  ))
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ],
                          );
                        },
                      ),

                    SizedBox(height: 20),

                    // 📍 Observations Map Data
                    Text("Observations",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    if (taxon != null)
                      FutureBuilder<List<Observation>>(
                        future: INaturalistAPI.getObservations(taxon!.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError ||
                              snapshot.data == null) {
                            return Text("No recent observations.");
                          }
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width,
                              child: GoogleMapsWidget(
                                  locations: snapshot.data!
                                      .where((element) =>
                                          element.latitude != null &&
                                          element.longitude != null)
                                      .toList()),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
