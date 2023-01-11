import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login%20screen/shop_login.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/app_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var passController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    defaultTextFormField(
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Write your Name';
                          } else {
                            return null;
                          }
                        },
                        type: TextInputType.text,
                        isSecure: false,
                        controller: nameController,
                        prefix: Icons.person,
                        label: 'Name',
                        function: () {}),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Write your Phone';
                          } else {
                            return null;
                          }
                        },
                        type: TextInputType.phone,
                        isSecure: false,
                        controller: phoneController,
                        prefix: Icons.phone_android,
                        label: 'phone ',
                        function: () {}),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Write your email';
                          } else {
                            return null;
                          }
                        },
                        type: TextInputType.emailAddress,
                        isSecure: false,
                        controller: emailController,
                        prefix: Icons.email_outlined,
                        label: 'email ',
                        function: () {}),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Write your password';
                          } else {
                            return null;
                          }
                        },
                        type: TextInputType.phone,
                        isSecure: true,
                        controller: passController,
                        prefix: Icons.lock,
                        // suffix: AppCubit.get(context).isVisible == false
                        //     ? Icons.visibility
                        //     : Icons.visibility_off,
                        label: 'password ',
                        function: () {
                          // AppCubit.get(context).changePassVisibility();
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    defaultElvButton(
                        text: 'REGISTER',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            navigateTo(context, const ShopAppLoginScreen());
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text('Don\'t have an email?'),
                        defaultTextButton(function: () {}, text: 'Register')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
