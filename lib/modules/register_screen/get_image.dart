import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/modules/login%20screen/shop_login.dart';
import 'package:shop_app/modules/register_screen/register_cubit/register_app_states.dart';
import 'package:shop_app/modules/register_screen/register_cubit/register_cubit.dart';
import 'package:shop_app/shared/components/components.dart';

class ImageSelection extends StatelessWidget {
  ImageSelection({Key? key}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterAppStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          RegisterCubit cubit = BlocProvider.of(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text(''),
            ),
            body: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  defaultTextButton(
                      text: 'Skip',
                      function: () {
                        navigateTo(context, const ShopAppLoginScreen());
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.18,
                        child: ClipOval(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: (cubit.selectedImage != null)
                                ? Image.file(
                                    cubit.selectedImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.04,
                        backgroundColor: HexColor('#F2F3F4'),
                        child: IconButton(
                          onPressed: () {
                            scaffoldKey.currentState
                                ?.showBottomSheet((context) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15))),
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          defaultElvButton(
                                              width: MediaQuery.of(context).size.width *0.3,
                                              text: 'Gallery',
                                              function: () {
                                                cubit.pickImage(
                                                    ImageSource.gallery);
                                              }),
                                          defaultElvButton(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              text: 'Camera',
                                              function: () {
                                                cubit.pickImage(
                                                    ImageSource.camera);
                                              }),
                                        ],
                                      ),
                                    ));
                          },
                          icon: const Icon(Icons.add_photo_alternate, size: 40),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  defaultElvButton(text: 'Login', function: (){
                    cubit.userRegister(
                      image: cubit.selectedImage.toString(),
                    );
                    navigateAndFinish(context, const ShopAppLoginScreen());
                    if (kDebugMode) {
                      print('photo saved');
                    }
                  })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
