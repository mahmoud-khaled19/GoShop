import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import '../../../shared/cubit/app_cubit.dart';

class ProductDetails extends StatelessWidget {
  final String image;
  final dynamic price;
  final dynamic id;
  final String name;
  final String description;

  const ProductDetails(
      {required this.image,
      required this.name,
      required this.price,
      required this.description,
      super.key,
      this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, Object? state) {
        ShopCubit.get(context).favourites[id]!
            ? Icons.favorite
            : Icons.favorite;
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('')),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: NetworkImage(image),
                          height: 300,
                          width: double.infinity,
                        ),
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
              ),
              Container(
                  margin: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        color: Colors.grey[200],
                        child: InkWell(
                          onTap: () {
                            ShopCubit.get(context).changeFavoriteState(id);
                          },
                          child: Icon(
                            ShopCubit.get(context).favourites[id]!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                            size: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              color: Colors.black,
                              height: 40,
                              child: const Center(
                                  child: Text(
                                'Add To Bag',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ))))
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }
}
