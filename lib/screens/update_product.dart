import 'package:flutter/material.dart';
import 'package:flutter_api_test/models/product.dart';
import 'package:flutter_api_test/services/api_services.dart';

class UpdateProduct extends StatefulWidget {
  final Product product;
  const UpdateProduct({super.key, required this.product});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  ApiServices apiServices = ApiServices();
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String category;
  late String discription;
  late String image;
  late double price;

  @override
  void initState() {
    title = widget.product.title;
    category = widget.product.category;
    discription = widget.product.discription;
    image = widget.product.image;
    price = widget.product.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
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
                initialValue: discription,
                decoration: const InputDecoration(label: Text("discription")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter the tilte";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  discription = newValue!;
                },
              ),
              TextFormField(
                initialValue: category,
                decoration: const InputDecoration(label: Text("category")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter the tilte";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  category = newValue!;
                },
              ),
              TextFormField(
                initialValue: image,
                decoration: const InputDecoration(label: Text("image")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter the tilte";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  image = newValue!;
                },
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: const InputDecoration(label: Text("price")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter the tilte";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  price = double.parse(newValue!);
                },
              ),
              //update product
              ElevatedButton(
                  onPressed: () {
                    //check validity
                    if (_formKey.currentState!.validate()) {
                      //save current state
                      _formKey.currentState!.save();
                      Product updatedProduct = Product(
                          title: title,
                          discription: discription,
                          price: price,
                          category: category,
                          image: image);
                      apiServices
                          .updateProduct(widget.product.id!, updatedProduct)
                          .then((value) => Navigator.pop);
                    }
                  },
                  child: const Text("Update Product")),
            ],
          ),
        ),
      ),
    );
  }
}
