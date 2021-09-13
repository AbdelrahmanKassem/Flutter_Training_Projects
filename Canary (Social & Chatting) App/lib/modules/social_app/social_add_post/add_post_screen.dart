import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/social_app/cubit/cubit.dart';
import 'package:my_first_app/layout/social_app/cubit/states.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/styles/colors.dart';
import 'package:my_first_app/shared/styles/icon_broken.dart';

class AddNewPostScreen extends StatelessWidget {

  var textController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              cubit.removePostImage();
              Navigator.pop(context);
            },
            icon: Icon(
              IconBroken.Arrow___Left_2,
            ),
          ),
          titleSpacing: 5,
          title: Text(
            'Create Post',
            style: TextStyle(
              color: defaultColor,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 10.0,
              ),
              child: Container(
                color: Colors.grey[400],
                width: 1,
              ),
            ),
            TextButton(
              onPressed: (){
                if(formKey.currentState!.validate()){
                  if(cubit.postImage == null)
                  {
                    cubit.createPost(postText: textController.text);
                  }
                  else
                  {
                    cubit.uploadPostImageAndCreatePost(postText: textController.text);
                  }
                  showToast(
                    messege: 'We are adding your post...',
                    state: ToastState.SUCCESS,
                  );
                  cubit.removePostImage();
                  Navigator.pop(context);
                }
              },
              child: Text(
                'POST',
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('${cubit.model!.profileImage}'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Billi Eilish',
                          style: TextStyle(
                            height: 1.4,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Public',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.4,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: Form(
                  key: formKey,
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: textController,
                      maxLines: 200,
                      validator: (value)
                      {
                        if((value == null || value!.isEmpty) && cubit.postImage == null)
                          {
                            return 'Post cannot be empty';
                          }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'What\'s on your mind ?',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              if(cubit.postImage != null)
                Stack(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.zero,
                      child: Image(
                        fit: BoxFit.cover,
                        height: 180,
                        width: double.infinity,
                        image: FileImage(File(cubit.postImage.path)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        child: IconButton(
                          onPressed: (){
                            cubit.removePostImage();
                          },
                          icon: Icon(
                            IconBroken.Delete,
                          ),
                        ),
                      ),
                    ),
                  ],
                  alignment: AlignmentDirectional.topEnd,
                ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: (){
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Add Photo',
                            ),
                          ],
                        ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Colors.grey[400],
                      width: 1,
                      height: 30,
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: (){

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.tag,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'tags',
                            ),
                          ],
                        ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      },
    );
  }
}
