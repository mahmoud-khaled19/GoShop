import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import '../../../view_model/cubit/register_cubit/register_app_states.dart';
import '../../../view_model/cubit/register_cubit/register_cubit.dart';
import '../../../view_model/shared/components/components.dart';
import '../login screen/shop_login.dart';

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
              navigateAndFinish(context, const ShopAppLoginScreen());
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
                        AppStrings.register.tr(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      defaultTextFormField(
                        context: context,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.validateName.tr();
                          } else {
                            return null;
                          }
                        },
                        type: TextInputType.text,
                        isSecure: false,
                        controller: nameController,
                        prefix: Icons.person,
                        label: AppStrings.nameLabel.tr(),
                      ),
                      defaultTextFormField(
                        context: context,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.validatePhone.tr();
                          } else {
                            return null;
                          }
                        },
                        type: TextInputType.phone,
                        isSecure: false,
                        controller: phoneController,
                        prefix: Icons.phone_android,
                        label: AppStrings.phoneLabel.tr(),
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
                          type: TextInputType.phone,
                          label: AppStrings.passwordLabel.tr(),
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
                            context: context,
                            text: AppStrings.register.tr(),
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
