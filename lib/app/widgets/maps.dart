import 'package:calgaryhacks/app/models/observation.model.dart';
import 'package:calgaryhacks/app/models/taxon.model.dart';
import 'package:calgaryhacks/app/modules/scan/controllers/scan_controller.dart';
import 'package:calgaryhacks/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsWidget extends StatefulWidget {
  final List<Observation> locations;

  GoogleMapsWidget({required this.locations});

  @override
  _GoogleMapsWidgetState createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  late GoogleMapController mapController;

  // Initial camera position (default to the first location in the list)
  late CameraPosition _initialPosition;

  Set<Marker> _createMarkers() {
    return widget.locations.map((location) {
      return Marker(
        markerId: MarkerId(location.id.toString()),
        position: LatLng(location.latitude!, location.longitude!),
        infoWindow:
            InfoWindow(title: "${location.placeGuess}\n${location.observedOn}"),
      );
    }).toSet();
  }

  final List<Map<String, dynamic>> speciesLocations = [
    {
      "commonName": "Grizzly Bear",
      "scientificName": "Ursus arctos horribilis",
      "location": LatLng(51.048615, -114.070847),
      "imageUrl":
          "https://images.unsplash.com/photo-1568162603664-fcd658421851?q=80&w=2881&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "commonName": "Bald Eagle",
      "scientificName": "Haliaeetus leucocephalus",
      "location": LatLng(51.053615, -114.075847),
      "imageUrl":
          "https://plus.unsplash.com/premium_photo-1661955263952-59ad9453efb8?q=80&w=3017&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "commonName": "Moose",
      "scientificName": "Alces alces",
      "location": LatLng(51.043615, -114.065847),
      "imageUrl":
          "https://images.unsplash.com/photo-1549471013-3364d7220b75?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "commonName": "Wolf",
      "scientificName": "Canis lupus",
      "location": LatLng(51.057615, -114.085847),
      "imageUrl":
          "https://plus.unsplash.com/premium_photo-1664303208329-58bd1b4e30c3?q=80&w=2926&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "commonName": "Cougar",
      "scientificName": "Puma concolor",
      "location": LatLng(51.038615, -114.055847),
      "imageUrl":
          "https://plus.unsplash.com/premium_photo-1664304328664-ee6ee2a4412f?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "commonName": "Great Horned Owl",
      "scientificName": "Bubo virginianus",
      "location": LatLng(51.060615, -114.095847),
      "imageUrl":
          "https://plus.unsplash.com/premium_photo-1661963650531-da13a49590ab?q=80&w=2918&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "commonName": "Bison",
      "scientificName": "Bison bison",
      "location": LatLng(51.045615, -114.068847),
      "imageUrl":
          "https://images.unsplash.com/photo-1560950409-d1ada256f246?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "commonName": "Red Fox",
      "scientificName": "Vulpes vulpes",
      "location": LatLng(51.050615, -114.072847),
      "imageUrl":
          "https://images.unsplash.com/photo-1474511320723-9a56873867b5?q=80&w=2944&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "commonName": "Elk",
      "scientificName": "Cervus canadensis",
      "location": LatLng(51.042615, -114.064847),
      "imageUrl":
          "https://images.unsplash.com/photo-1487213802982-74d73802997c?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "commonName": "Coyote",
      "scientificName": "Canis latrans",
      "location": LatLng(51.055615, -114.082847),
      "imageUrl":
          "https://images.unsplash.com/photo-1580515283754-f75a7eed937d?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
  ];
  String locationMessage = "Press the button to get location";

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;

    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = "Location services are disabled.";
      });
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage = "Location permissions are denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage =
            "Location permissions are permanently denied. Enable them from settings.";
      });
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _initialPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 11,
    );

    setState(() {
      locationMessage =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });
  }

  Future<void> load() async {
    await _getCurrentLocation();
  }

  @override
  void initState() {
    super.initState();
    if (widget.locations.isNotEmpty)
      _initialPosition = CameraPosition(
        target: LatLng(widget.locations.first.latitude!,
            widget.locations.first.longitude!),
        zoom: 2,
      );
    else
      _initialPosition = CameraPosition(
        target: LatLng(51.048615, -114.070847),
        zoom: 12.8,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        circles: widget.locations.isEmpty
            ? {
                Circle(
                  circleId: CircleId("radius"),
                  center: LatLng(51.048615, -114.070847),
                  radius: 2000, // Radius in meters (2km)
                  strokeWidth: 2,
                  strokeColor: Colors.blue.withOpacity(0.5),
                  fillColor: Colors.blue.withOpacity(0.2),
                ),
              }
            : {},
        markers: widget.locations.isEmpty
            ? speciesLocations.map((species) {
                return Marker(
                  markerId: MarkerId(species["scientificName"]),
                  position: species["location"],
                  infoWindow: InfoWindow(
                    title: species["scientificName"],
                    snippet: "Tap for details",
                    onTap: () {
                      ScanController scanController =
                          Get.find<ScanController>();
                      scanController.isFromCam.value = false;
                      scanController.currentTaxon.value = TaxonModel(
                          totalResults: 1,
                          page: 1,
                          perPage: 1,
                          results: [
                            Result(
                                combinedScore: 1,
                                visionScore: 1,
                                taxon: Taxon(
                                    defaultPhoto: DefaultPhoto(
                                        id: 1,
                                        url: species['imageUrl'],
                                        mediumUrl: species['imageUrl'],
                                        squareUrl: species['imageUrl']),
                                    id: 1,
                                    rank: '1',
                                    name: species['commonName'],
                                    iconicTaxonName: species['scientificName'],
                                    preferredCommonName: species['commonName']))
                          ]);
                      Get.toNamed(Routes.SCAN_DETAILS);
                    },
                  ),
                );
              }).toSet()
            : _createMarkers(),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
