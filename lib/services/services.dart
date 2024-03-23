import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thegrandemarche/model/model.dart';

class RestaurantService {
  static Future<List<Restaurant>> fetchRestaurants() async {
  final response = await http.get(Uri.parse('https://run.mocky.io/v3/9c7d5c0d-5dd9-4b72-b158-fcf4f61a956b'));
  if (response.statusCode == 200) {
    dynamic responseData = jsonDecode(response.body);
    // Check if responseData is a List<dynamic> or a single JSON object (JsonMap)
    if (responseData is List) {
      List<Restaurant> restaurants = responseData.map((json) => Restaurant.fromJson(json)).toList();
      return restaurants;
    } else if (responseData is Map<String, dynamic>) {
      // Handle single JSON object
      Restaurant restaurant = Restaurant.fromJson(responseData);
      return [restaurant];
    } else {
      throw Exception('Invalid data format from API');
    }
  } else {
    throw Exception('Failed to load restaurants');
  }
}


  static Future<void> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
  }
}
