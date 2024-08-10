import 'package:flutter/material.dart';
import 'package:flutter_api_test/models/product.dart';
import 'package:flutter_api_test/screens/update_product.dart';
import 'package:flutter_api_test/services/api_services.dart';

class SingleProductPage extends StatefulWidget {
  final int productId;
  const SingleProductPage({super.key, required this.productId});

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  final ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Single product page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: FutureBuilder<Product>(
            future: apiServices.getSingleProduct(widget.productId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("something went wrong ${snapshot.error}"),
                );
              } else if (!snapshot.hasData) {
                return const Center(child: Text("No data found"));
              } else {
                Product product = snapshot.data!;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        product.image,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        product.title,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Text(
                        "Price : ${product.price.toString()}",
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        product.discription,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateProduct(product: product),
                                    ));
                              },
                              child: Text("Update Product")),
                          ElevatedButton(
                              onPressed: () {
                                apiServices.deleteProduct(product.id!);
                              },
                              child: Text("Delete Product")),
                        ],
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
