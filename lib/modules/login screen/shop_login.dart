import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login%20screen/login_cubit/login_app_states.dart';
import 'package:shop_app/modules/login%20screen/login_cubit/login_cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import '../register_screen/register_screen.dart';

class ShopAppLoginScreen extends StatelessWidget {
  const ShopAppLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginAppStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (  state.loginModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                    token =state.loginModel.data!.token;
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              defaultToast(text: state.loginModel.message!, color: Colors.red);
            }
          } else if (state is LoginErrorState) {
            defaultToast(
                text: ' تأكد من الاتصال بالانترنت ', color: Colors.green);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login To Koota Shop and Browse our Offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        defaultTextFormField(
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter your Email';
                              } else {
                                return null;
                              }
                            },
                            type: TextInputType.emailAddress,
                            isSecure: false,
                            controller: emailController,
                            prefix: Icons.email_outlined,
                            label: 'Email Address',
                            function: () {}),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter your password';
                              } else {
                                return null;
                              }
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            type: TextInputType.phone,
                            isSecure: LoginCubit.get(context).isVisible,
                            controller: passwordController,
                            prefix: Icons.lock,
                            suffix: LoginCubit.get(context).isVisible == false
                                ? Icons.visibility
                                : Icons.visibility_off,
                            label: 'password ',
                            function: () {
                              LoginCubit.get(context).changePassVisibility();
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                        Visibility(
                          replacement:
                              const Center(child: CircularProgressIndicator()),
                          visible: state is! LoginLoadingState,
                          child: defaultElvButton(
                              text: 'Login',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text('Don\'t have an email?'),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, const RegisterScreen());
                                },
                                text: 'Register')
                          ],
                        )
                      ],
                    ),
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
