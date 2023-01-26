import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  required Function() function,
  Function(String value)? onSubmit,
}) =>
    TextFormField(
      keyboardType: type,
      obscureText: isSecure,
      onFieldSubmitted:onSubmit,
      controller: controller,
      validator: validate,
      decoration: InputDecoration(
          label: Text(label),
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(onPressed: function,icon:Icon(suffix) ,),
          border:const OutlineInputBorder(
            borderRadius:  BorderRadius.only(topRight: Radius.circular(20),bottomLeft:  Radius.circular(20),
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
          style: const TextStyle(color: Colors.blue,fontSize: 12),
        ));
Widget defaultElvButton({
  required String text,
  required Function() function,
  double width =double.infinity,
  Color color =Colors.blue
}) =>
    Container(
      width: width,
      decoration:  BoxDecoration(
        color: color,
        borderRadius:const BorderRadius.only(topRight: Radius.circular(20),bottomLeft:  Radius.circular(20))
      ),
      child: TextButton(
          onPressed: function,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(color: Colors.white,fontSize: 16),
          )),
    );
Future<bool?> defaultToast({
  required String text,
  required Color color,
})=>
    Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: color,
    fontSize: 16.0
);
