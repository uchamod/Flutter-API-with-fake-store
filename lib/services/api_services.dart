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

  //save a new product
  Future<Product> saveProduct(Product product) async {
    String url = "https://fakestoreapi.com/products";
    try {
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode(product.toJson(product)));
      print("status code ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        Product newProduct = Product.fromJson(json.decode(response.body));
        print("save new product ${response.body}");
        return newProduct;
      } else {
        print("data is not fetched from server ${response.statusCode}");
        throw Exception("somthing went wrong");
      }
    } catch (err) {
      print("the error is " + err.toString());
      throw Exception("data is not fetched:somthing went wrong");
    }
  }

  //update a product
  Future<Product> updateProduct(int id, Product product) async {
    String url = "https://fakestoreapi.com/products/$id";
    try {
      final updatedProduct = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson(product)),
      );
      print("status code ${updatedProduct.statusCode}");
      if (updatedProduct.statusCode == 200 ||
          updatedProduct.statusCode == 201) {
        Product newProduct = Product.fromJson(json.decode(updatedProduct.body));
        print("updated the product ${updatedProduct.body}");
        return newProduct;
      } else {
        print("data is not fetched from server ${updatedProduct.statusCode}");
        throw Exception("somthing went wrong");
      }
    } catch (err) {
      print("the error is " + err.toString());
      throw Exception("data is not fetched:somthing went wrong");
    }
  }

  //delete product
  Future<void> deleteProduct(int id) async {
    String url = "https://fakestoreapi.com/products/$id";
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("delete product succsussfuly ${response.body}");
      } else {
        print("failed to delete product ${response.statusCode}");
      }
    } catch (err) {
      print("the error is " + err.toString());
      throw Exception("data is not fetched:somthing went wrong");
    }
  }
}
