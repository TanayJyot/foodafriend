import 'package:buildspace_s5/deliverer/screens/order_tracking.dart';
import 'package:buildspace_s5/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/queue_model.dart';

class AvailableOrders extends StatefulWidget {
  final String? location;
  const AvailableOrders({super.key, this.location});

  @override
  State<AvailableOrders> createState() => _AvailableOrdersState();
}

class _AvailableOrdersState extends State<AvailableOrders> {
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  Future<Iterable<OrderQueue>> _fetchOrderQueue() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Order Queue')
        .get();
    return await DatabaseService().orderQueueFromSnapshot(snapshot);
  }

  void _deleteOrder(String documentId) async {
    try {
      await FirebaseFirestore.instance.collection('Order Queue')
          .doc(documentId)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Widget orderCard({
    required String name,
    required String item,
    required String restaurant,
    required String distance,
    required String address,
    required String eta,
    required String documentId,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderTrackingPage(sourceLocation: sourceLocation, destination: destination, name: name, item: item,),
          ));
          _deleteOrder(documentId);
        },
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                '$distance, ETA: $eta',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "$name would like a $item from $restaurant on $address",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Location box and Dashboard button
            Padding(
              padding: EdgeInsets.all(15.r),
              child: Row(
                children: [
                  // Location box
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 25.sp,
                              color: Colors.pink,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Heading to",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  Text(
                                    widget.location ?? "Robarts Library",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.angleDown,
                              size: 15.sp,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  // Dashboard button
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // This will take you back to the previous screen (dashboard)
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: Icon(
                        Icons.restaurant_menu,
                        size: 24.sp,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Available Orders text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.r),
              child: Row(
                children: [
                  Text(
                    "Available Orders",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Order list
            Expanded(
              child: FutureBuilder<Iterable<OrderQueue>>(
                future: _fetchOrderQueue(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.pink));
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No orders available'));
                  } else {
                    return ListView(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      children: snapshot.data!.map((order) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: orderCard(
                            name: order.name ?? "Default",
                            item: order.item ?? "Default",
                            restaurant: "Burger Corner",
                            distance: "2 km",
                            address: "23 Bloor St",
                            eta: "25 min walk",
                            documentId: order.id ?? "Default",
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
