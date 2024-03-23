// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thegrandemarche/screens/login.dart';
import 'package:thegrandemarche/screens/restaurants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future restaurant;
  Future getRestaurantData() async {
    try {
      final result = await http.get(
        Uri.parse(
          'https://run.mocky.io/v3/9c7d5c0d-5dd9-4b72-b158-fcf4f61a956b',
        ),
      );

      final data = jsonDecode(result.body);

      if (result.statusCode != 200) {
        throw 'An unexpected error occurred';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    restaurant = getRestaurantData();
  }

  List<String> images = [
    
  "https://media.istockphoto.com/photos/restaurant-terrace-picture-id1210737093?b=1&k=20&m=1210737093&s=170667a&w=0&h=foay8gYQ3G9Vv2v9YVBJkV2TMYExKpBzbWSUR0n40G8=",
  "https://media.istockphoto.com/photos/cozy-restaurant-interior-picture-id1215272442?b=1&k=20&m=1215272442&s=170667a&w=0&h=STQiyu9V9F0bKlS68BtHfZJ_VkmUEHsf8Q_FKsO-3I4=",
  "https://media.istockphoto.com/photos/modern-restaurant-interior-picture-id1179992116?b=1&k=20&m=1179992116&s=170667a&w=0&h=GR88cjNfVLJMyQ-b4K7x3blTzjP5QCNs-6l_U4UG2-U=",
  "https://media.istockphoto.com/photos/elegant-restaurant-interior-design-picture-id1209502155?b=1&k=20&m=1209502155&s=170667a&w=0&h=CyqgGTDBWQ8v8DcGwA0cOymC0pVXwIiFlU_2rKnDW7s=",
  "https://media.istockphoto.com/photos/beautiful-bakery-shop-interior-picture-id1189990081?b=1&k=20&m=1189990081&s=170667a&w=0&h=9NzdcVKyV-R1AUpMJ18htObOeZwUKz7TtU-gdqcl7Cs=",
  "https://media.istockphoto.com/photos/elegant-interior-of-modern-restaurant-picture-id1201764053?b=1&k=20&m=1201764053&s=170667a&w=0&h=yVT3bx4DSjrUTOf8C0f-ANlSmpYzY4gP_hk6XKZHB2k=",
  "https://media.istockphoto.com/photos/elegant-restaurant-interior-picture-id1220847333?b=1&k=20&m=1220847333&s=170667a&w=0&h=FkG8u5vYNFXKs7iY_bv-rkTCH5lxFH_T3yGGYgVpTn8=",
  "https://media.istockphoto.com/photos/elegant-restaurant-interior-design-picture-id1210710810?b=1&k=20&m=1210710810&s=170667a&w=0&h=YxRQzwuX_zCgFnDSotyyVsZ6JtMH1D-qWmO7gC2-E8c=",
  "https://media.istockphoto.com/photos/elegant-restaurant-interior-design-picture-id1210710885?b=1&k=20&m=1210710885&s=170667a&w=0&h=rrtW4nlmQyjDlaxmyOVs4xJbwioXw2C7wQBBqG2y_6c=",
  "https://media.istockphoto.com/photos/elegant-restaurant-interior-design-picture-id1210711079?b=1&k=20&m=1210711079&s=170667a&w=0&h=zVln-cLvLpPJ5thR7fRupZzscH4L0UV6S4xKg5j6Lq8=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: const Text(
          "RESTAURANTS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async{
              final _sharedPref = await SharedPreferences.getInstance();
              await _sharedPref.clear();

            },
            child: const Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: FutureBuilder(
        future: restaurant,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final data = snapshot.data!;
          final restaurantData = data["restaurants"];
          return ListView.builder(
            itemCount: restaurantData.length,
            itemBuilder: (context, index) {
              return ListItem(
                restaurant: restaurantData[index],
                img: images[index],
              );
            },
          );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({
    super.key,
    required this.restaurant,
    required this.img,
  });
  // ignore: prefer_typing_uninitialized_variables
  final restaurant;
  String img;

  @override
  Widget build(BuildContext context) {
    num sum = 0;
    for (int i = 0; i < restaurant["reviews"].length; i++) {
      sum = sum + restaurant["reviews"][i]["rating"];
    }

    double rating = sum / restaurant["reviews"].length;
    rating = (rating * 10).round() / 10.0;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 5,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>  Restaurants(restaurant: restaurant, img: '', rating: '',),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 0.5,
            )
          ]),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Text(
                      restaurant["name"],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 25,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green[600],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.cancel,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          restaurant["cuisine_type"],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_sharp,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          restaurant["address"],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}