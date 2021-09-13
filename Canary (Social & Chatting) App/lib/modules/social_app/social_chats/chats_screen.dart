import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/social_app/cubit/cubit.dart';
import 'package:my_first_app/layout/social_app/cubit/states.dart';
import 'package:my_first_app/modules/social_app/social_chat_details/chat_details_screen.dart';
import 'package:my_first_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getAllUsers();
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state) => ConditionalBuilder(
        condition: SocialCubit.get(context).allUsersModel.length > 0,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView.separated(
              itemBuilder: (context,index) => buildChatItem(context,SocialCubit.get(context).allUsersModel[index]),
              separatorBuilder: (context,index) => myDivider(),
              itemCount: SocialCubit.get(context).allUsersModel.length,
          ),
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildChatItem(context,userModel) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(receivingUserModel: userModel));
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('${userModel.profileImage}'),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${userModel.name}',
                  style: TextStyle(
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: (){

            },
            icon: Icon(
              Icons.more_horiz,
              size: 17,
            ),
          ),
        ],
      ),
    ),
  );
}
