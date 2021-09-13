import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/social_app/social_layout.dart';
import 'package:my_first_app/modules/social_app/social_register/social_register_screen.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/network/local/cache_helper.dart';
import 'package:my_first_app/shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state) {
          if(state is SocialLoginErrorState)
            {
              showToast(
                  messege: state.error,
                  state: ToastState.ERROR,
              );
            }
          if(state is SocialLoginSuccessState)
            {
              CacheHelper.setData(key: 'uId', value: '${state.uId}'
              ).then(
                      (value){
                    navigateAndFinish(context, SocialLayout());
                  }
              );
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
                        'LOGIN',
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
                        'Login to find nearby friends now.',
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
                          suffixIcon: SocialLoginCubit.get(context).isPassword? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          suffixPressed: (){
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: SocialLoginCubit.get(context).isPassword,
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
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialLoginLoadingState,
                        builder: (context) => defaultButton(
                          backgroundColor: defaultColor,
                          text: 'LOGIN',
                          function: ()
                          {
                            if(formKey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: (){
                              navigateTo(context, SocialRegisterScreen());
                            },
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                              ),
                            ),
                          ),
                        ],
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
