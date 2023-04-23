import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/app_constance/strings_manager.dart';

import '../../view_model/cubit/app_cubit.dart';


Widget defaultTextFormField({
  required TextEditingController controller,
  required BuildContext context,
  required String? Function(String? val)? validate,
  bool isSecure = false,
  TextInputType type = TextInputType.emailAddress,
  required String label,
  IconData prefix = Icons.login,
  IconData? suffix,
  Function()? function,
  Function(String value)? onSubmit,
}) =>
    Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            keyboardType: type,
            obscureText: isSecure,
            onFieldSubmitted: onSubmit,
            controller: controller,
            validator: validate,
            decoration: InputDecoration(
              label: Text(
                label,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              prefixIcon: Icon(
                prefix,
                color: Theme.of(context).iconTheme.color,
              ),
              suffixIcon: IconButton(
                onPressed: function,
                icon: Icon(
                  suffix,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )),
            )),
      ],
    );

Widget defaultTextButton({
  required String text,
  required Function() function,
}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(color: Colors.blue, fontSize: 12),
        ));

Widget defaultElvButton({
  required String text,
  required Function() function,
  context,
  double width = double.infinity,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
      child: TextButton(
          onPressed: function,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )),
    );

Future<bool?> defaultToast({
  required String text,
  required Color color,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);

Widget productListItem(context, model) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image(
                  image: NetworkImage(model.product.image),
                  height: MediaQuery.of(context).size.height * 0.21,
                  width: double.infinity,
                ),
              ),
              if (model.product.discount != 0)
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child:  Text(
                  AppStrings.discount.tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'EGP ${model.product!.price.toString()}',
                  maxLines: 1,
                  style:  Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: 8),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context)
                        .changeFavoriteState(model.product!.id!);
                  },
                  icon: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      ShopCubit.get(context).favourites[model.product!.id!]!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

Widget listTileWidget({
  context,
  required String text,
  Function()? function,
  IconData? icon,
}) =>
    GestureDetector(
      onTap: function,
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          style: ListTileStyle.list,
          title: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: Icon(
                icon,
                color: Theme.of(context).splashColor,
              )
        ),
      ),
    );
