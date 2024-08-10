import 'package:flutter/material.dart';
import 'package:flutter_api_test/models/product.dart';
import 'package:flutter_api_test/services/api_services.dart';

class CreateNewProduct extends StatefulWidget {
  const CreateNewProduct({super.key});

  @override
  State<CreateNewProduct> createState() => _CreateNewProductState();
}

class _CreateNewProductState extends State<CreateNewProduct> {
  ApiServices apiServices = ApiServices();
  final _formKey = GlobalKey<FormState>();

  String title = "";
  String category = "";
  String discription = "";
  String image = "";
  double price = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(label: Text("Title")),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter the tilte";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    title = newValue!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("discription")),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter the discription";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    discription = newValue!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("category")),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter the category";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    category = newValue!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("image")),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter the image";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    image = newValue!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("price")),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter the price";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    price = double.parse(newValue!);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  //add new product
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //save current data
                      _formKey.currentState!.save();
                      Product product = Product(
                          title: title,
                          discription: discription,
                          category: category,
                          image: image,
                          price: price);
                      apiServices.saveProduct(product);
                      apiServices
                          .saveProduct(product)
                          .then((value) => Navigator.pop(context));
                    }
                  },
                  child: const Text("Add new Product"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
