import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
 late String image;
 late dynamic price;
 late String name;
 late String description;
 ProductDetails({required this.image,required this.name,
   required this.price,required this.description,super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:  Text('Product Details')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: NetworkImage(image), height: 300,
                width: double.infinity,),
              const SizedBox(
                height: 10,
              ),
              Text('$price'),
              const SizedBox(
                height: 10,
              ),
              Text(name),
              const SizedBox(
                height: 20,
              ),
              Text(description),

            ],
          ),
        ),
      ),
    );
  }
}
