import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_first_app/layout/shop_app/cubit/states.dart';
import 'package:my_first_app/shared/cubit/cubit.dart';

Widget defaultButton({
  required String text,
  required void Function() function,
  Color backgroundColor = Colors.blue,
  Color textColor = Colors.white,
  double width = double.infinity,
  double height = 50,
  bool upperCase = true,
  double borderRadius = 0,
}) => Container(
  width: width,
  height: height,
  decoration: BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(borderRadius),
  ),
  child: MaterialButton(
    onPressed: function,
    child: Text(
      upperCase? text.toUpperCase() : text,
      style: TextStyle(
        color: textColor,
      ),
    ),
  ),
);


Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String lableText,
  required IconData prefixIcon,
  double height = 1.1,
  bool isPassword = false,
  bool readOnly = false,
  IconData? suffixIcon,
  void Function()? suffixPressed,
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  void Function()? onTap,
  required String? Function(String?)? validator,

}) => TextFormField(
  style: TextStyle(
    height: height,
  ),
  readOnly: readOnly,
  controller: controller,
  keyboardType: keyboardType,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText: lableText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    prefixIcon: Icon(
      prefixIcon,
    ),
    suffixIcon:  IconButton(
      icon: Icon(
        (suffixIcon != null)? suffixIcon : null,
      ),
      onPressed: suffixPressed,
    ),

  ),
  onFieldSubmitted: onFieldSubmitted,
  onChanged: onChanged,
  onTap: onTap,
  validator: validator,
);


void navigateTo(context,widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
  (route)
  {
  return false;
  },
);

enum ToastState {
  SUCCESS,ERROR,WARNING,
}

Color selectToastColor(ToastState state)
{
  Color toastColor;

  switch(state)
  {
    case ToastState.SUCCESS:
      toastColor = Colors.green;
      break;
    case ToastState.ERROR:
      toastColor = Colors.red;
      break;
    case ToastState.WARNING:
      toastColor = Colors.amberAccent;
      break;
  }

  return toastColor;
}

void showToast({
  required String messege,
  required ToastState state,
})
{
  Fluttertoast.showToast(
      msg: messege,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: selectToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15,),
  child: Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey[300],
  ),
);
