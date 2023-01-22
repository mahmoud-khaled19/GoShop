import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class AboutMe extends StatelessWidget {

  final String? name;
  final String? phone;
  final String? email;

   const AboutMe({super.key, this.name,this.email,this.phone});
  @override
  Widget build(BuildContext context) {
    double size =MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('About Me')),
      ),
      body: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return Column(
            children:  [
              Container(
                color: Colors.grey[100],
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  title: const Text("Name"),
                  subtitle:Text(name!) ,
                ),
              ),
              SizedBox(
                  height: size *0.01
              ),
              Container(
                color: Colors.grey[100],
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child:  ListTile(

                  title: const Text("Email"),
                  subtitle:Text(email!) ,
                ),
              ),
              SizedBox(
                  height: size *0.01
              ),
              Container(
                color: Colors.grey[100],
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child:  ListTile(
                  title:const Text("Phone"),
                  subtitle:Text(phone!) ,
                ),
              ),
            ],
          );
    },

      ));
  }
}
