import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login%20screen/shop_login.dart';
import 'package:shop_app/modules/register_screen/register_cubit/register_app_states.dart';
import 'package:shop_app/modules/register_screen/register_cubit/register_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../style/colors.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var passController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterAppStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.model.status!) {
              navigateAndFinish(context,  ShopAppLoginScreen());
              defaultToast(text: state.model.message!, color: Colors.green);
            } else {
              defaultToast(text: state.model.message!, color: Colors.red);
            }
          } else if (state is RegisterErrorState) {
            defaultToast(
                text: ' تأكد من الاتصال بالانترنت ', color: Colors.green);
          }
        },
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
                           color: ShopCubit.get(context).isDark ? darkPrimaryColor
                                : Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      defaultTextFormField(
                          borderColor:  ShopCubit.get(context).isDark
                              ? lightPrimaryColor
                              : Colors.white,
                          color: ShopCubit.get(context).isDark? Colors.white:Colors.red,
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
                          borderColor:  ShopCubit.get(context).isDark
                              ? lightPrimaryColor
                              : Colors.white,
                          color: ShopCubit.get(context).isDark? Colors.white:Colors.red,
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
                          borderColor:  ShopCubit.get(context).isDark
                              ? lightPrimaryColor
                              : Colors.white,
                          color: ShopCubit.get(context).isDark? Colors.white:Colors.red,
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
                        borderColor:  ShopCubit.get(context).isDark
                            ? lightPrimaryColor
                            : Colors.white,
                          color: ShopCubit.get(context).isDark? Colors.white:Colors.red,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Write your password';
                            } else {
                              return null;
                            }
                          },
                          type: TextInputType.phone,
                          label: 'password ',
                          isSecure: RegisterCubit.get(context).visible == false
                              ? false
                              : true,
                          controller: passController,
                          prefix: Icons.lock,
                          suffix: RegisterCubit.get(context).visible == false
                              ? Icons.visibility
                              : Icons.visibility_off,
                          function: () {
                            RegisterCubit.get(context).changePassVisibility();
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      Visibility(
                        replacement:
                        const Center(child: CircularProgressIndicator()),
                        visible: state is! RegisterLoadingState,
                        child: defaultElvButton(
                            text: 'Register',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    password: passController.text);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
