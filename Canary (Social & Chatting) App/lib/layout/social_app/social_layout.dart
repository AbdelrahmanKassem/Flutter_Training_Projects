import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/social_app/cubit/cubit.dart';
import 'package:my_first_app/layout/social_app/cubit/states.dart';
import 'package:my_first_app/modules/social_app/social_add_post/add_post_screen.dart';
import 'package:my_first_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/styles/colors.dart';
import 'package:my_first_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getUserData();
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state) {},
      builder: (context,state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          titleSpacing: 15,
          title: Text(
            cubit.titles[cubit.currentIndex],
            style: TextStyle(
              color: defaultColor,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.8,
            ),
          ),
          actions: [
            if(SocialCubit.get(context).currentIndex == 4)
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
            if(SocialCubit.get(context).currentIndex == 4)
              TextButton(
                onPressed: (){
                  uId = null;
                  cubit.model = null;
                  navigateAndFinish(context, SocialLoginScreen());
                },
                child: Text(
                  'LOGOUT',
                  style: TextStyle(
                    height: 2.3,
                    color: defaultColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
            ),
          ],
        ),
        floatingActionButton: cubit.currentIndex == 0 || cubit.currentIndex == 4? FloatingActionButton(
          tooltip: 'Create Post',
          elevation: 10,
          mini: true,
          onPressed: (){
            navigateTo(context, AddNewPostScreen());
          },
          child: Icon(
            IconBroken.Edit,
          ),
        ) : null,
        bottomNavigationBar: BottomNavigationBar(
          enableFeedback: true,
          iconSize: 25,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              tooltip: 'Home',
              icon: Icon(
                  IconBroken.Home
              ),
            ),
            BottomNavigationBarItem(
              label: 'Chats',
              tooltip: 'Chats',
              icon: Icon(
                  IconBroken.Chat
              ),
            ),
            BottomNavigationBarItem(
              label: 'Notifications',
              tooltip: 'Notifications',
              icon: Icon(
                IconBroken.Notification,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Users',
              tooltip: 'Users',
              icon: Icon(
                  IconBroken.Location
              ),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              tooltip: 'Settings',
              icon: Icon(
                  IconBroken.Setting
              ),
            ),
          ],
          onTap: (index){
            cubit.changeBottomNav(index);
          },
          currentIndex: cubit.currentIndex,
        ),
        body: ConditionalBuilder(
          condition: SocialCubit.get(context).model != null,
          builder: (context) => cubit.screens[cubit.currentIndex],
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ),
      );
      },
    );
  }
}
