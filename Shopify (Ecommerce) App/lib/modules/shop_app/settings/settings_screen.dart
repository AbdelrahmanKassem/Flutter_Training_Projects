import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/shop_app/cubit/cubit.dart';
import 'package:my_first_app/layout/shop_app/cubit/states.dart';
import 'package:my_first_app/modules/basics_app/login/login_screen.dart';
import 'package:my_first_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(ShopCubit.get(context).shopUserData == null)
      {
        ShopCubit.get(context).getUserData();
      }
    nameController.text = ShopCubit.get(context).shopUserData!.data!.name.toString();
    emailController.text = ShopCubit.get(context).shopUserData!.data!.email.toString();
    phoneController.text = ShopCubit.get(context).shopUserData!.data!.phone.toString();

    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,states) {},
        builder: (context,states) => ConditionalBuilder(
          condition: ShopCubit.get(context).shopUserData != null && states is! ShopLoadingUpdateProfileState && states is! ShopLoadingUserDataState,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(states is ShopLoadingUpdateProfileState) LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        lableText: 'Name',
                        prefixIcon: Icons.person,
                        validator: (value){
                          if(value == null || value.isEmpty)
                          {
                            return 'Name cannot be empty';
                          }
                          return null;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        lableText: 'Email',
                        prefixIcon: Icons.email,
                        validator: (value){
                          if(value == null || value.isEmpty)
                          {
                            return 'Email cannot be empty';
                          }
                          return null;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        lableText: 'Phone',
                        prefixIcon: Icons.phone,
                        validator: (value){
                          if(value == null || value.isEmpty)
                          {
                            return 'Name cannot be empty';
                          }
                          return null;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        backgroundColor: defaultColor,
                        text: 'UPDATE DATA',
                        function: (){
                          if(formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).updateUserProfile(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                            while(states is ShopLoadingUpdateProfileState)
                              {

                              }
                              ShopCubit.get(context).getUserData();
                          }
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        backgroundColor: defaultColor,
                        text: 'LOGOUT',
                        function: (){
                          signOut(context);
                          navigateAndFinish(context, ShopLoginScreen());
                        }
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ),
    );
  }

}