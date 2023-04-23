import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/strings_manager.dart';

import '../../../../view_model/cubit/app_cubit.dart';
import '../../../../view_model/cubit/app_states.dart';
import '../../../widgets/widgets.dart';

class PrivacyScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hSize = MediaQuery.of(context).size.height;
    double wSize = MediaQuery.of(context).size.width;

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopUpdateUserinfoSuccessState) {
          defaultToast(text: 'تم تحديث البيانات بنجاح', color: Colors.green);
        }
      },
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  AppStrings.update.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            body: BlocConsumer<ShopCubit, ShopStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var model = cubit.userInfo!;
                return ConditionalBuilder(
                  condition: cubit.userInfo != null,
                  builder: (BuildContext context) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            if (state is ShopUpdateUserinfoLoadingState)
                              const LinearProgressIndicator(),
                            SizedBox(
                              height: hSize * 0.03,
                            ),
                            defaultTextFormField(
                                context: context,
                                prefix: Icons.person,
                                type: TextInputType.text,
                                controller: nameController,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    nameController.text = model.data!.name!;
                                  }
                                  return;
                                },
                                label: AppStrings.nameLabel.tr()),
                            defaultTextFormField(
                                context: context,
                                prefix: Icons.phone_android,
                                type: TextInputType.phone,
                                controller: phoneController,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    phoneController.text = model.data!.phone!;
                                  }
                                  return;
                                },
                                label: AppStrings.phoneLabel.tr()),
                            defaultTextFormField(
                                context: context,
                                prefix: Icons.email,
                                type: TextInputType.emailAddress,
                                controller: emailController,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    emailController.text = model.data!.email!;
                                  }
                                  return null;
                                },
                                label: AppStrings.emailLabel.tr(),
                                function: () {}),
                            SizedBox(
                              height: hSize * 0.04,
                            ),
                            defaultElvButton(
                                context: context,
                                width: wSize * 0.4,
                                text: AppStrings.update.tr(),
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.updateUserdata(
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
                  fallback: (BuildContext context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ));
      },
    );
  }
}
