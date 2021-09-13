import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_first_app/layout/shop_app/shop_layout.dart';
import 'package:my_first_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:my_first_app/modules/shop_app/login/cubit/states.dart';
import 'package:my_first_app/modules/shop_app/register/shop_register_screen.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/network/local/cache_helper.dart';
import 'package:my_first_app/shared/styles/colors.dart';

class ShopLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state) {
          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status == true)
                {
                  print(state.loginModel.messege);
                  print(state.loginModel.data!.token);
                  CacheHelper.setData(key: 'token', value: '${state.loginModel.data!.token}'
                  ).then(
                      (value){
                        token = state.loginModel.data!.token;
                        navigateAndFinish(context, ShopLayout());
                      }
                  );
                }
              else
                {
                  print(state.loginModel.messege);
                  showToast(
                    messege: '${state.loginModel.messege}',
                    state: ToastState.ERROR,
                  );
                }
            }
          else if(state is ShopLoginErrorState)
            {
              print(state.error);
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
                        'Login to see all our current hot offers!',
                        style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 17,
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
                          suffixIcon: ShopLoginCubit.get(context).isPassword? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          suffixPressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
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
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButton(
                            backgroundColor: defaultColor,
                            text: 'LOGIN',
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
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
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: (){
                                navigateTo(context, ShopRegisterScreen());
                              },
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                  fontSize: 17,
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
