import 'package:flutter/material.dart';
import 'package:flutter_api_test/models/product.dart';
import 'package:flutter_api_test/screens/create_new_product.dart';
import 'package:flutter_api_test/screens/single_product_page.dart';
import 'package:flutter_api_test/services/api_services.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text("All Products"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateNewProduct(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: FutureBuilder<List<Product>>(
          future: apiServices.getAllData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Data Not Found"),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Product product = snapshot.data![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white60),
                    child: ListTile(
                      leading: Image.network(
                        product.image,
                        fit: BoxFit.fill,
                      ),
                      title: Text(product.title),
                      subtitle: Text(product.price.toString()),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleProductPage(
                                productId: product.id!,
                              ),
                            ));
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
