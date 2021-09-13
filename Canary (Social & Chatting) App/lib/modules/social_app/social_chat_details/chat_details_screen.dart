import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/social_app/cubit/cubit.dart';
import 'package:my_first_app/layout/social_app/cubit/states.dart';
import 'package:my_first_app/models/user/social_app/chats_model.dart';
import 'package:my_first_app/models/user/social_app/social_users_model.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/styles/colors.dart';
import 'package:my_first_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel receivingUserModel;
  ChatDetailsScreen({required this.receivingUserModel});

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getMessages(receiverId: receivingUserModel.uId.toString());
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              IconBroken.Arrow___Left_2,
            ),
          ),
          titleSpacing: 5,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${receivingUserModel.profileImage}',),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '${receivingUserModel.name}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length > 0,
                builder: (context) => Expanded(
                  child: ListView.separated(padding: EdgeInsets.all(10),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      if(SocialCubit.get(context).messages[index].senderId == SocialCubit.get(context).model!.uId)
                        {
                          return buildMyMessage(SocialCubit.get(context).messages[index]);
                        }
                      else
                        {
                          return buildReceivedMessage(SocialCubit.get(context).messages[index]);
                        }
                    },
                    separatorBuilder: (context,index) => SizedBox(height: 15,),
                    itemCount: SocialCubit.get(context).messages.length,
                  ),
                ),
                fallback: (context) => Expanded(child: Center(child: CircularProgressIndicator())),
              ),
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  border: Border.all(color: defaultColor),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          onFieldSubmitted: (value){
                            SocialCubit.get(context).sendMessage(
                              text: textController.text,
                              receiverId: receivingUserModel.uId.toString(),
                            );
                            textController.text = '';
                          },
                          controller: textController,
                          validator: (value){
                            if(value!.isEmpty)
                              {
                                return null;
                              }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Write text here...',
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){
                        SocialCubit.get(context).sendMessage(
                            text: textController.text,
                            receiverId: receivingUserModel.uId.toString(),
                        );
                        textController.text = '';
                      },
                      child: Icon(
                        IconBroken.Send,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMyMessage(ChatsModel message) => Align(
    alignment: Alignment.topLeft,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          '${message.text}',
        ),
      ),
    ),
  );
  Widget buildReceivedMessage(ChatsModel message) => Align(
    alignment: Alignment.topRight,
    child: Container(
      decoration: BoxDecoration(
        color: defaultColor.shade200,
        border: Border.all(
          color: defaultColor.shade200,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          '${message.text}',
        ),
      ),
    ),
  );
}
