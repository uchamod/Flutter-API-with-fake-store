import 'dart:convert';

import 'package:flutter_api_test/models/product.dart';
import 'package:http/http.dart' as http;

//api services
class ApiServices {
//get all data
  Future<List<Product>> getAllData() async {
    //get url
    const String url = "https://fakestoreapi.com/products";
    try {
      final respons = await http.get(Uri.parse(url));
      //check the status and get the product list
      if (respons.statusCode == 200) {
        List<dynamic> responseData = json.decode(respons.body);
        List<Product> products = responseData.map((json) {
          return Product.fromJson(json);
        }).toList();
        return products;
      } else {
        print("data is not fetched from server ${respons.statusCode}");
        throw Exception("somthing went wrong");
      }
    } catch (err) {
      print("the error is " + err.toString());
      throw Exception("data is not fetched:somthing went wrong");
    }
  }
  //get single data
  Future<Product> getSingleProduct(int id) async {
    String url = "https://fakestoreapi.com/products/$id";
    try {
      final respones = await http.get(Uri.parse(url));
      if (respones.statusCode == 200) {
        dynamic responesData = json.decode(respones.body);
        Product product = Product.fromJson(responesData);
        return product;
      } else {
        print("data is not fetched from server ${respones.statusCode}");
        throw Exception("somthing went wrong");
      }
    } catch (err) {
      print("the error is " + err.toString());
      throw Exception("data is not fetched:somthing went wrong");
    }
  }
}
