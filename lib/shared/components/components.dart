import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../style/colors.dart';
import '../cubit/app_cubit.dart';

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required String? Function(String? val)? validate,
  bool isSecure = false,
  TextInputType type = TextInputType.emailAddress,
  required String label,
  IconData prefix = Icons.login,
  IconData? suffix,
  required Color color,
   Color? prefixColor,
   Color? suffixColor,
   required Color borderColor,
   Color? textColor,
  required Function() function,
  Function(String value)? onSubmit,
}) =>
    TextFormField(
        style: TextStyle(color: textColor),
        keyboardType: type,
        obscureText: isSecure,
        onFieldSubmitted: onSubmit,
        controller: controller,
        validator: validate,
        decoration: InputDecoration(

          label: Text(label,style: TextStyle(
            color: color
          ),),
          prefixIcon: Icon(prefix,color: prefixColor,),
          suffixIcon: IconButton(
            onPressed: function,
            icon: Icon(suffix,color: suffixColor,),
          ),
          border:  OutlineInputBorder(
            borderSide: BorderSide(
             color: borderColor
            ),
              borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
        ));

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

Widget defaultElvButton(
        {required String text,
        required Function() function,
        double width = double.infinity,
        Color color = Colors.blue}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
          color: color,
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
        backgroundColor: Colors.green,
        textColor: color,
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
                  child: const Text(
                    'Discount',
                    style: TextStyle(color: Colors.white),
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
                  style: TextStyle(
                      height: 1.8,
                      fontSize: 14,
                      color: model.product!.discount != 0
                          ? lightPrimaryColor
                          : Colors.black),
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
Widget settingItem({
  Color? contColor,
  required String text,
  Color? texColor,
  Color? iconColor,
  Function()? function,
  IconData? icon
})=>  Container(
  color:contColor,
  margin: const EdgeInsets.symmetric(horizontal: 10),
  child: ListTile(
    style: ListTileStyle.list,
    title:  Text(text,style: TextStyle(
        color:texColor
    ),),
    trailing: IconButton(
      onPressed: function,
      icon:   Icon(icon,color: iconColor,)
    ),
  ),
);