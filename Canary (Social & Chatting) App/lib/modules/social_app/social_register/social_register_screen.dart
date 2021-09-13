import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/social_app/social_layout.dart';
import 'package:my_first_app/modules/social_app/social_register/cubit/cubit.dart';
import 'package:my_first_app/modules/social_app/social_register/cubit/states.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/styles/colors.dart';

class SocialRegisterScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state) {
          if(state is SocialCreateUserSuccessState)
            {
              navigateAndFinish(context,SocialLayout());
            }
        },
        builder: (context,state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: TextStyle(
                          letterSpacing: 1.7,
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Register to find nearby friends now.',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      defaultTextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          lableText: 'User Name',
                          prefixIcon: Icons.person,
                          validator: (value)
                          {
                            if(value == null || value.isEmpty)
                            {
                              return 'User Name Can\'t be empty';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          lableText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          validator: (value)
                          {
                            if(value == null || value.isEmpty)
                            {
                              return 'Email Can\'t be empty';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          lableText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: SocialRegisterCubit.get(context).isPassword? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          suffixPressed: (){
                            SocialRegisterCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: SocialRegisterCubit.get(context).isPassword,
                          validator: (value)
                          {
                            if(value == null || value.isEmpty)
                            {
                              return 'Email Can\'t be empty';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          lableText: 'Phone',
                          prefixIcon: Icons.phone,
                          validator: (value)
                          {
                            if(value == null || value.isEmpty)
                            {
                              return 'Phone Can\'t be empty';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadingState && state is! SocialCreateUserLoadingState && state is! SocialCreateUserSuccessState,
                        builder: (context) => defaultButton(
                          backgroundColor: defaultColor,
                          text: 'REGISTER',
                          function: ()
                          {
                            if(formKey.currentState!.validate())
                            {
                              SocialRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
