import 'package:buildspace_s5/receiver/screens/heropage/item_screens/restaurant_menu.dart';
import 'package:buildspace_s5/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../services/auth.dart';
import 'my_behaviour.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});



  @override
  State<StatefulWidget> createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  final AuthService _auth = AuthService();
  late DatabaseService _database;
  List<dynamic> restaurants = [];

  List<String> tabName = [
    "sort",
    "Fast Delivery",
    "Rating 4.0+",
    "New Arrivals",
    "Pure Veg",
    "Cuisines",
    "More",
  ];

  List<String> category = [
    "Pizza",
    "Biryani",
    "Shake",
    "Burger",
    "Chicken",
    "Sandwich",
    "Noodles",
    "Frid Rice",
    "Thali",
    "Cake",
    "Panner",
    "Dosa",
    "Ice Cream",
    "Rolls",
    "Paratha",
    "Chaat",
  ];

  Future get_data() async {
    _database = DatabaseService(uid: _auth.get_current_user()!.uid);
    restaurants = await _database.getRestaurants();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      color: Colors.pink,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),

                //appbar dynamic Create
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 25.sp,
                        color: Colors.pink,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Location",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: FaIcon(
                                  FontAwesomeIcons.angleDown,
                                  size: 15.sp,
                                ),
                              ),
                            ],
                          ),
                          const Text("City")
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey[300]!)),
                        child: const Center(child: Icon(Icons.shopping_cart)),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          height: 30.h,
                          width: 30.w,
                          child: GestureDetector(
                            onTap: () => _auth.signOut(),
                            child: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiaLO5Z4Ga_OJMvDSNnn2b_UT6iMUvWU2Btg&usqp=CAU",
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //search box
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.grey[300]!)),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          const Flexible(
                            child: TextField(
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: "Search for a Restaurant or Dish",
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.pink,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const VerticalDivider(),
                          const Icon(
                            Icons.keyboard_voice_outlined,
                            color: Colors.pink,
                          ),
                          SizedBox(
                            width: 10.w,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                    itemCount: tabName.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(5.h),
                        child: Container(
                          child: index == 0
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border:
                                          Border.all(color: Colors.grey[300]!)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Icon(
                                        Icons.tune,
                                        size: 10.sp,
                                      ),
                                      Text(
                                        "sort",
                                        style: TextStyle(fontSize: 10.sp),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.angleDown,
                                        size: 10.sp,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                    ],
                                  ),
                                )
                              : index == 5 || index == 6
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(
                                              color: Colors.grey[300]!)),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            tabName[index],
                                            style: TextStyle(fontSize: 10.sp),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.angleDown,
                                            size: 10.sp,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(
                                              color: Colors.grey[300]!)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 5.h),
                                        child:
                                            Center(child: Text(tabName[index])),
                                      ),
                                    ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(child: Divider()),
                              SizedBox(
                                width: 10.w,
                              ),
                              Center(
                                  child: Text(
                                "OFFERS FOR YOU",
                                style: TextStyle(color: Colors.grey[500]!),
                              )),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100.h,
                          child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: GestureDetector(
                                  onTap: () {
                                    if (index != 1) {}
                                  },
                                  child: SizedBox(
                                    height: 100.h,
                                    width: 100.w,
                                    child: Image.asset(
                                      "assets/images/frame${index + 1}.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(child: Divider()),
                              SizedBox(
                                width: 10.w,
                              ),
                              Center(
                                  child: Text(
                                "WHAT'S ON YOUR MIND?",
                                style: TextStyle(color: Colors.grey[500]!),
                              )),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 180.h,
                          child: GridView.count(
                            scrollDirection: Axis.horizontal,
                            crossAxisCount: 2,
                            children: List.generate(
                                16,
                                (index) => Column(
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        SizedBox(
                                          height: 50.h,
                                          child: Image.asset(
                                            "assets/images/category/ic_frame${index + 1}.jpg",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Text(category[index])
                                      ],
                                    )),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(child: Divider()),
                              SizedBox(
                                width: 10.w,
                              ),
                              Center(
                                  child: Text(
                                "RESTAURANTS",
                                style: TextStyle(color: Colors.grey[500]!),
                              )),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                        ),
                        restaurants.isEmpty
                            ? const SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: restaurants.length,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RestaurantMenu()));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        child: Card(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                        height: 150.h,
                                                        width: double.infinity,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      10.r),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.r),
                                                            ),
                                                            child: Image.asset(
                                                              "assets/item_images/burgers/burger${index + 1}.jpeg",
                                                              fit: BoxFit.fill,
                                                            ))),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.h),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 20.h,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              const Icon(
                                                                Icons.alarm,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              SizedBox(
                                                                width: 5.w,
                                                              ),
                                                              Text(restaurants[
                                                                      index]
                                                                  ["hours"]),
                                                              const Spacer(),
                                                              const Text(
                                                                  "\$150 for one"),
                                                              SizedBox(
                                                                width: 5.w,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Positioned(
                                                    top: 10.h,
                                                    right: 10.w,
                                                    child: Icon(
                                                      Icons.favorite_outline,
                                                      size: 20.sp,
                                                    )),
                                                Positioned(
                                                    bottom: 90.h,
                                                    left: 10.w,
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            restaurants[index]
                                                                ['name'],
                                                            style: TextStyle(
                                                                shadows: const [
                                                                  Shadow(
                                                                    color: Colors
                                                                        .black,
                                                                    blurRadius:
                                                                        5,
                                                                  ),
                                                                ],
                                                                fontSize: 20.sp,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "American Burgers",
                                                                style: TextStyle(
                                                                    shadows: [
                                                                      Shadow(
                                                                        color: Colors
                                                                            .black,
                                                                        blurRadius:
                                                                            5,
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              SizedBox(
                                                                width: 140.w,
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(10
                                                                            .r),
                                                                    color: Colors
                                                                        .green),
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              5.w),
                                                                  child:
                                                                      const Text(
                                                                    "4.0★",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                                Positioned(
                                                    left: 10.w,
                                                    bottom: 40.h,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const RestaurantMenu()),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 40.h,
                                                        width: 310.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          gradient:
                                                              const LinearGradient(
                                                            colors: [
                                                              Colors.indigo,
                                                              Colors
                                                                  .indigoAccent
                                                            ],
                                                            begin: Alignment
                                                                .bottomLeft,
                                                            end: Alignment
                                                                .topRight,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.percent,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            const Text(
                                                              "50% OFF up to 100",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            SizedBox(
                                                              width: 140.w,
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .indigo,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.r)),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5
                                                                            .sp),
                                                                child:
                                                                    const Text(
                                                                  "+1",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
