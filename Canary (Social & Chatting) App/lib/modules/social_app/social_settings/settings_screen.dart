import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/social_app/cubit/cubit.dart';
import 'package:my_first_app/layout/social_app/cubit/states.dart';
import 'package:my_first_app/modules/social_app/social_edit_profile/edit_profile_screen.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getUserData();
    var cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state) {},
      builder: (context,state) {
        return SingleChildScrollView(
          child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Card(
                          elevation: 5,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: EdgeInsets.zero,
                          child: Image(
                              fit: BoxFit.cover,
                              height: 180,
                              width: double.infinity,
                              image: NetworkImage('${cubit.model!.coverImage}'),
                            ),
                        ),
                        SizedBox(height: 40,)
                      ],
                    ),
                  ),
                  Card(
                    elevation: 10,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      radius: 56,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage('${cubit.model!.profileImage}'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${cubit.model!.name}',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 1.1,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${cubit.model!.bio}',
              style: Theme.of(context).textTheme.caption!.copyWith(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '51',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Posts',
                            style: Theme.of(context).textTheme.caption!,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '236',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Photos',
                            style: Theme.of(context).textTheme.caption!,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '2K',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Followers',
                            style: Theme.of(context).textTheme.caption!,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '324',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Following',
                            style: Theme.of(context).textTheme.caption!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: OutlinedButton(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(defaultColor),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed:(){
                  navigateTo(context, EditProfileScreen());
                },
              ),
            ),
          ],
      ),
        );
      },
    );
  }
}
