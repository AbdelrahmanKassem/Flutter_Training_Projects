import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/shared/components/components.dart';

class Loginscreen extends StatefulWidget
{
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  IconData passwordSuffixIcon = Icons.remove_red_eye_outlined;
  bool hidePasswordText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        //fontStyle: FontStyle.italic,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    defaultTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        lableText: 'Email Address',
                        prefixIcon: Icons.email,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Email must not be empty.';
                          }
                          return null;
                        },
                    ),
                    /*
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        //hintText: 'Email Address',
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                      ),
                      onFieldSubmitted: (value)
                      {
                        print(value);
                      },
                      onChanged: (value)
                      {
                        print(value);
                      },
                      validator: (value)
                      {
                        if(value!.isEmpty)
                          {
                            return 'Email must not be empty.';
                          }
                        return null;
                      },
                    ),

                     */
                    SizedBox(
                      height: 20,
                    ),
/*
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: hidePasswordText,
                      decoration: InputDecoration(
                        //hintText: 'Password',
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                              passwordSuffixIcon,
                          ),
                          onPressed: (){
                            setState(() {
                              if(passwordSuffixIcon == Icons.remove_red_eye)
                                {
                                  passwordSuffixIcon = Icons.remove_red_eye_outlined;
                                  hidePasswordText = false;
                                }
                              else
                                {
                                  passwordSuffixIcon = Icons.remove_red_eye;
                                  hidePasswordText = true;
                                }
                            });
                          },
                        ),
                      ),
                      onFieldSubmitted: (value)
                      {
                        print(value);
                      },
                      onChanged: (value)
                      {
                        print(value);
                      },
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'Password must not be empty.';
                        }
                        return null;
                      },
                    ),

*/

                    defaultTextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      lableText: 'Password',
                      prefixIcon: Icons.lock,
                      suffixIcon: hidePasswordText? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                      suffixPressed: (){
                        setState(() {
                          hidePasswordText = !hidePasswordText;
                        });
                      },
                      isPassword: hidePasswordText,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'Password must not be empty.';
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 40,
                    ),

                    //login button hard-coded
/*
                    Container(
                      width: double.infinity,
                      color: Colors.blue,
                      child: MaterialButton(
                        onPressed: ()
                        {
                          print(emailController.text);
                          print(passwordController.text);
                        },
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

*/
                  //button component that I made
                    defaultButton(
                        text: 'login',
                        function: (){
                          if(formKey.currentState!.validate())
                            {
                              print(emailController.text);
                              print(passwordController.text);
                            }
                        },
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account ?'
                        ),
                        TextButton(
                          onPressed: ()
                          {

                          },
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}