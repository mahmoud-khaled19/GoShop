import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import '../../../../view_model/cubit/login_cubit/login_app_states.dart';
import '../../../../view_model/cubit/login_cubit/login_cubit.dart';
import '../../../../view_model/shared/network/local/shared_preferences.dart';
import '../../../widgets/widgets.dart';
import '../../home/layout/shop_layout.dart';
import '../register_screen/register_screen.dart';

class ShopAppLoginScreen extends StatelessWidget {
  ShopAppLoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    double size = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginAppStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                AppMethods.token = state.loginModel.data!.token!;
                AppMethods.navigateAndFinish(context, const ShopLayout());
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
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.welcome.tr(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          height: size * 0.01,
                        ),
                        Text(
                          AppStrings.loginMessage.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: size * 0.05,
                        ),
                        defaultTextFormField(
                          context: context,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return AppStrings.validateEmail.tr();
                            } else {
                              return null;
                            }
                          },
                          type: TextInputType.emailAddress,
                          isSecure: false,
                          controller: emailController,
                          prefix: Icons.email_outlined,
                          label: AppStrings.emailLabel.tr(),
                        ),
                        defaultTextFormField(
                            context: context,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return AppStrings.validatePassword.tr();
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
                            suffix: LoginCubit.get(context).isVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            label: AppStrings.passwordLabel.tr(),
                            function: () {
                              LoginCubit.get(context).changePassVisibility();
                            }),
                        SizedBox(
                          height: size * 0.04,
                        ),
                        Visibility(
                          replacement:
                              const Center(child: CircularProgressIndicator()),
                          visible: state is! LoginLoadingState,
                          child: defaultElvButton(
                              context: context,
                              text: AppStrings.login.tr(),
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }),
                        ),
                        SizedBox(
                          height: size * 0.02,
                        ),
                        Row(
                          children: [
                            Text(AppStrings.donHaveEmail.tr()),
                            defaultTextButton(
                                function: () {
                                  AppMethods.navigateTo(
                                      context, RegisterScreen());
                                },
                                text: AppStrings.register.tr())
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
