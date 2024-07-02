import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DeliveryDetails extends StatefulWidget {
  final LatLng sourceLocation, destination;
  final Map<String, String> deliveryData;
  const DeliveryDetails(
      {super.key,
      required this.sourceLocation,
      required this.destination,
      required this.deliveryData});
  @override
  State<DeliveryDetails> createState() => DeliveryDetailsState();
}

class DeliveryDetailsState extends State<DeliveryDetails> {
  final Completer<GoogleMapController> _controller = Completer();
  bool follow = true;

  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print("Location service not enabled");
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print("location permission not granted");
        return;
      }
    }

    location.getLocation().then(
      (location) {
        setState(() {
          currentLocation = location;
        });
      },
    );

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((LocationData newLoc) {
      currentLocation = newLoc;
      if (follow) {
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
      }
      location.enableBackgroundMode(enable: true);
      setState(() {});
    });
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineRequest polylineRequest = PolylineRequest(
        origin: PointLatLng(
            widget.sourceLocation.latitude, widget.sourceLocation.longitude),
        destination: PointLatLng(
            widget.destination.latitude, widget.destination.longitude),
        mode: TravelMode.driving);
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request: polylineRequest,
        googleApiKey: "AIzaSyDPU0Taag1cKPTbtV0awCqPjIYcwsOPx7Y");
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void _goToDelivery() async {
    GoogleMapController googleMapController = await _controller.future;
    if (currentLocation != null) {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(
              currentLocation!.latitude!,
              currentLocation!.longitude!,
            ),
          ),
        ),
      );
    }
    setState(() {
      follow = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getPolyPoints();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 1.75,
              width: double.maxFinite,
              child: currentLocation == null
                  ? const Center(child: Text("Loading"))
                  : Listener(
                      onPointerDown: (event) {
                        if (follow) {
                          setState(() {
                            follow = false;
                          });
                        }
                      },
                      child: GoogleMap(
                        gestureRecognizers: {
                          Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                          ),
                        },
                        // mapType: MapType.hybrid,
                        myLocationButtonEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                          zoom: 13.5,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId("currentLocation"),
                            position: LatLng(currentLocation!.latitude!,
                                currentLocation!.longitude!),
                            onTap: () => setState(() {
                              follow = true;
                            }),
                          ),
                          Marker(
                            markerId: MarkerId("source"),
                            position: widget.sourceLocation,
                            infoWindow: const InfoWindow(
                              title: "Restaurant",
                              snippet: "Your food is picked up from here",
                            ),
                          ),
                          Marker(
                            markerId: MarkerId("destination"),
                            position: widget.destination,
                            infoWindow: const InfoWindow(
                              title: "Destination",
                              snippet: "Your food will be delivered here",
                            ),
                          ),
                        },
                        onMapCreated: (mapController) {
                          _controller.complete(mapController);
                        },
                        polylines: {
                          Polyline(
                            polylineId: const PolylineId("route"),
                            points: polylineCoordinates,
                            color: const Color(0xFF7B61FF),
                            width: 6,
                          ),
                        },
                      ),
                    ),
            ),
            Container(
              width: double.maxFinite,
              height: MediaQuery.sizeOf(context).height / 2.5,
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You are delivering for ${widget.deliveryData['name']}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.primary,
                    // endIndent: 25,
                    // indent: 25,
                  ),
                  Text(
                    "Order Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Restuarant: ${widget.deliveryData["restaurant"]}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Requested Food Item: ${widget.deliveryData["item"]}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Delivery Destination: ${widget.deliveryData["destination"]}"),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToDelivery,
        label: const Text('Recenter'),
        icon: const Icon(Icons.fastfood_rounded),
      ),
    );
  }
}
