import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final bool isSecure;
  final String label;
  final BuildContext context;
  final String Function(String? val)? validate;
  final IconData prefix;
  final IconData? suffix;
  final Function(String? val)? onSubmitted ;
  final Function()? suffixFunction;

  const DefaultTextFormField({
    super.key,
    required this.controller,
    this.type = TextInputType.emailAddress,
    this.isSecure = false,
    required this.prefix,
    required this.validate,
    required this.label,
    required this.context,
    required this.suffixFunction,
    required this.onSubmitted,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            keyboardType: type,
            obscureText: isSecure,
            onFieldSubmitted: onSubmitted,
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
                onPressed: suffixFunction,
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
  }
}
