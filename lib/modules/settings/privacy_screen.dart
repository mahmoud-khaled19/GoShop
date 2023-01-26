import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class PrivacyScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  var formKey =GlobalKey<FormState>();

  PrivacyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double hSize = MediaQuery.of(context).size.height;
    double wSize = MediaQuery.of(context).size.width;

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is    ShopUpdateUserinfoSuccessState ){
          defaultToast(text: 'تم تحديث البيانات بنجاح', color: Colors.green);
        }

      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Center(child: Text('update & Delete')),
            ),
            body: BlocConsumer<ShopCubit, ShopStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var model = ShopCubit.get(context).userInfo!;
                return ConditionalBuilder(
                  condition:ShopCubit.get(context).userInfo != null ,
                  builder: (BuildContext context)=>
                       SingleChildScrollView(
                         child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                if (state is ShopUpdateUserDataLoadingState )
                                const LinearProgressIndicator(),
                                 SizedBox(
                                  height: hSize * 0.03,
                                ),
                                defaultTextFormField(
                                    prefix: Icons.title,
                                    type: TextInputType.text,
                                    controller: nameController,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        nameController.text = model.data!.name!;
                                      }
                                      return;
                                    },
                                    label: 'Name',
                                    function: () {}),
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultTextFormField(
                                    prefix: Icons.phone_android,
                                    type: TextInputType.phone,
                                    controller: phoneController,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        phoneController.text = model.data!.phone!;
                                      }
                                      return;
                                    },
                                    label: 'phone',
                                    function: () {}),
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultTextFormField(
                                    prefix: Icons.email,
                                    type: TextInputType.emailAddress,
                                    controller: emailController,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        emailController.text = model.data!.email!;
                                      }
                                      return null;
                                    },
                                    label: 'email',
                                    function: () {}),
                                SizedBox(
                                  height: hSize * 0.04,
                                ),
                                defaultElvButton(
                                    width: wSize * 0.4,
                                    text: 'Update',
                                    function: () {
                                      if(formKey.currentState!.validate()){
                                        ShopCubit.get(context).updateUserdata(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          email: emailController.text,
                                        );

                                      }
                                    }),
                              ],
                            ),
                          ),
                      ),
                       ),
                  fallback: (BuildContext context)
                  =>  const Center(child: CircularProgressIndicator(),)
                  ,
                );
              },
            ));
      },
    );
  }
}
