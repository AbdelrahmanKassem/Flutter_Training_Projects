import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/social_app/cubit/cubit.dart';
import 'package:my_first_app/layout/social_app/cubit/states.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/styles/colors.dart';
import 'package:my_first_app/shared/styles/icon_broken.dart';
import 'package:image_picker/image_picker.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    nameController.text = cubit.model!.name.toString();
    bioController.text = cubit.model!.bio.toString();
    phoneController.text = cubit.model!.phone.toString();

    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state) {
        var profileImage = cubit.profileImage;
        var coverImage = cubit.coverImage;
        return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: (){
                cubit.clearUnsavedData();
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
              ),
          ),
          titleSpacing: 5,
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: defaultColor,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.grey[400],
                width: 1,
                height: double.infinity,
              ),
            ),
            TextButton(
            onPressed: (){
              cubit.updateUser(
                  name: nameController.text,
                  bio: bioController.text,
                  phone: phoneController.text,
              );
              cubit.clearUnsavedData();
              Navigator.pop(context);
            },
            child: Text(
              'SAVE',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Column(
          children: [
            if(state is SocialUpdateUserDataLoadingState)
              LinearProgressIndicator(),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height: 220,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Card(
                            elevation: 5,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            margin: EdgeInsets.zero,
                            child: Image(
                              fit: BoxFit.cover,
                              height: 180,
                              width: double.infinity,
                              image: coverImage == null ? NetworkImage('${cubit.model!.coverImage}') : FileImage(File(coverImage.path)) as ImageProvider,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              child: IconButton(
                                  onPressed: (){
                                    cubit.getCoverImage();
                                  },
                                  icon: Icon(
                                      IconBroken.Camera,
                                  ),
                              ),
                            ),
                          ),
                        ],
                        alignment: AlignmentDirectional.topEnd,
                      ),
                      SizedBox(height: 40,)
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Card(
                      elevation: 10,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        radius: 56,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: profileImage == null ? NetworkImage('${cubit.model!.profileImage}') : FileImage(File(profileImage.path)) as ImageProvider,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      child: IconButton(
                        onPressed: (){
                          cubit.getProfileImage();
                        },
                        icon: Icon(
                          IconBroken.Camera,
                        ),
                      ),
                    ),
                  ],
                  alignment: AlignmentDirectional.bottomEnd,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Column(
                  children: [
                    Container(
                      height:60,
                      child: defaultTextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        lableText: 'NAME',
                        prefixIcon: IconBroken.User,
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return 'Please enter your name.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 60,
                      child: defaultTextFormField(
                        controller: bioController,
                        keyboardType: TextInputType.text,
                        lableText: 'BIO',
                        prefixIcon: IconBroken.Info_Circle,
                        validator: (value){
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 60,
                      child: defaultTextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        lableText: 'PHONE',
                        prefixIcon: IconBroken.Call,
                        validator: (value){
                          if(value!.isEmpty)
                            {
                              return 'Please enter your phone number.';
                            }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
      },
    );
  }
}
