import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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


//Todo App
Widget defaultTaskItem(Map databaseItem,context) => Dismissible(
  key: Key(databaseItem['id'].toString()),
  child:   Container(

    height: 90,

    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(30),

      border: Border.all(

        color: Colors.grey,

        style: BorderStyle.solid,

        width: 0.4,

      ),

    ),

    padding: EdgeInsets.symmetric(horizontal: 10),

    child: Row(

      children: [

        CircleAvatar(

          backgroundColor: Colors.blue,

          radius: 40,

          child: Text(

            '${databaseItem['time']}',

            style: TextStyle(

              fontWeight: FontWeight.bold,

              color: Colors.white,

            ),

          ),

        ),

        SizedBox(

          width: 10,

        ),

        Expanded(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${databaseItem['title']}',

                style: TextStyle(

                  fontSize: 23,

                ),

              ),

              SizedBox(

                height: 5,

              ),

              Text(

                '${databaseItem['date']}',

                style: TextStyle(

                  fontSize: 15,

                  color: Colors.grey[700],

                ),

              ),

            ],

          ),

        ),

        IconButton(

            onPressed: ()

            {

              AppCubit.get(context).updateDataBase(id: databaseItem['id'],status: "DONE",);

            },

            icon: Icon(

              Icons.done_outline_rounded,

              color: Colors.green[800],

            ),

        ),

        IconButton(

          onPressed: ()

          {

            AppCubit.get(context).updateDataBase(id: databaseItem['id'],status: "ARCHIVED",);

          },

          icon: Icon(

            Icons.archive,

            color: Colors.red[900],

          ),

        ),

      ],

    ),

  ),
  onDismissed: (dismissDirection)
  {
    AppCubit.get(context).deleteFromDataBase(id: databaseItem['id']);
  },
);

Widget defaultTaskBuilder (databaseList) => ConditionalBuilder(
  condition: (databaseList?.length ?? 0)>0,
  builder: (context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.separated(
      itemBuilder: (context,index){
        return defaultTaskItem(databaseList![index] , context);
      },
      separatorBuilder: (context,index){
        return SizedBox(
          height: 10,
        );
      },
      itemCount: databaseList?.length ?? 0,
    ),
  ),
  fallback: (context) => Center(
    child: Text(
      'Empty',
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 25,
        fontStyle: FontStyle.italic,
      ),
    ),
  ),
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
