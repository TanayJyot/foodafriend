import 'package:buildspace_s5/receiver/screens/heropage/item_screens/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:buildspace_s5/models/food.dart';
import 'package:buildspace_s5/models/restaurant.dart';
import 'package:buildspace_s5/receiver/screens/heropage/item_screens/food_page.dart';
import 'package:provider/provider.dart';

class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({super.key});

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryTabs(),
          Expanded(
            child: _buildFoodItemsList(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.pink,
      title: Row(
        children: [
          Icon(
            Icons.location_on,
            size: 25.sp,
            color: Colors.white,
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deliver to",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                Row(
                  children: [
                    Text(
                      "Current Location",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: (
              ) {
            // Navigate to cart page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for dishes",
                  prefixIcon: Icon(Icons.search, color: Colors.pink),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic, color: Colors.pink),
              onPressed: () {
                // Implement voice search
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    List<String> categories = ["All", "Popular", "Recommended", "Burgers", "Pizzas", "Desserts"];
    return Container(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Chip(
              label: Text(categories[index]),
              backgroundColor: index == 0 ? Colors.pink : Colors.grey[200],
              labelStyle: TextStyle(color: index == 0 ? Colors.white : Colors.black),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodItemsList() {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        return ListView.builder(
          itemCount: restaurant.menu.length,
          itemBuilder: (context, index) {
            final food = restaurant.menu[index];
            return _buildFoodItemCard(food);
          },
        );
      },
    );
  }

  Widget _buildFoodItemCard(Food food) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodPage(food: food),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  food.imagePath,
                  width: 80.w,
                  height: 80.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      food.description,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '\$${food.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.pink),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}