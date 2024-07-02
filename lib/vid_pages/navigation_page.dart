import 'package:buildspace_s5/screens/order_tracking.dart';
import 'package:buildspace_s5/vid_pages/delivery_details.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationPage extends StatefulWidget {
  final Map<String, String> deliveryData;
  const NavigationPage({super.key, required this.deliveryData});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
      ),
      body: DeliveryDetails(
        sourceLocation: sourceLocation,
        destination: destination,
        deliveryData: widget.deliveryData,
      ),
    );
  }
}
