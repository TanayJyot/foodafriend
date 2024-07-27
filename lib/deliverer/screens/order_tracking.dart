import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {
  final LatLng sourceLocation, destination;
  final String name;
  final String item;
  const OrderTrackingPage(
      {super.key, required this.sourceLocation, required this.destination, required this.name, required this.item});
  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  bool follow = true;
  String userType = "delivery";

  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location service not enabled");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
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
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setState(() {});
    }
  }

  void _goToDelivery() async {
    if (userType == "delivery") {
      const snackBar = SnackBar(
        content: Text('Notified User'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
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
      appBar: AppBar(
        title: const Text("Delivery Details"),
      ),
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
                            markerId: const MarkerId("source"),
                            position: widget.sourceLocation,
                            infoWindow: const InfoWindow(
                              title: "Restaurant",
                              snippet: "Your food is picked up from here",
                            ),
                          ),
                          Marker(
                            markerId: const MarkerId("destination"),
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
                children: <Widget>[
                  Text(
                    "You are delivering for ${widget.name}",
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
                  const Text(
                    "Order Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Restaurant: Tim Hortons"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Requested Food Item: ${widget.item}"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Delivery Destination: 123 Anywhere St."),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToDelivery,
        label: userType == "delivery" ? const Text("I've Arrived") : const Text('Recenter'),
        icon: const Icon(Icons.fastfood_rounded),
      ),
    );
  }
}
