import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/social_app/cubit/cubit.dart';
import 'package:my_first_app/layout/social_app/cubit/states.dart';
import 'package:my_first_app/models/user/social_app/post_model.dart';
import 'package:my_first_app/shared/styles/colors.dart';
import 'package:my_first_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getPosts();
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state) {},
      builder: (context,state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.postsModel.length > 0 && cubit.model != null,
          builder: (context) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 12,
                margin: EdgeInsetsDirectional.all(8),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image(
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                      image: NetworkImage('https://image.freepik.com/free-photo/albino-girl-with-white-skin-natural-lips-white-hair-neon-light-isolated-black-studio-background_155003-21895.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Closer Than Ever !',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14,),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index) => buildPostItem(context,cubit.postsModel[index],index),
                separatorBuilder: (context,index) => SizedBox(height: 14,),
                itemCount: cubit.postsModel.length,
              ),
              SizedBox(height: 60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'End of feed, for Now...',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
      ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem (context,PostModel postModel,index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${postModel.profileImage}'),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${postModel.name}',
                      style: TextStyle(
                        height: 1.4,
                      ),
                    ),
                    Text(
                      '${postModel.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
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
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          if(postModel.postText != '')
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '${postModel.postText}',
              style: TextStyle(
                height: 1.6,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      end:7.0
                  ),
                  child: Container(
                    height:31,
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    child: TextButton(
                      onPressed: (){

                      },
                      style: ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Text(
                        '#New_Start',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      end:7.0
                  ),
                  child: Container(
                    height:31,
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    child: TextButton(
                      onPressed: (){

                      },
                      style: ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Text(
                        '#Motivated',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if(postModel.postImage != '')
          Container(
            padding: EdgeInsets.only(top: 5),
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${postModel.postImage}'),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap:(){},
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16,
                          color: defaultColor,
                        ),
                        Text(
                          '${SocialCubit.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Chat,
                          size: 16,
                          color: defaultColor,
                        ),
                        Text(
                          '0 Comment',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage('${SocialCubit.get(context).model!.profileImage}'),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  'Write a comment...',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(7),
                onTap: (){
                  if(SocialCubit.get(context).isLiked[index] == true)
                    {
                      SocialCubit.get(context).likes[index] = SocialCubit.get(context).likes[index] - 1;
                      SocialCubit.get(context).unLikePost(SocialCubit.get(context).postsId[index]);
                      SocialCubit.get(context).isLiked[index] = false;
                    }
                  else
                    {
                      SocialCubit.get(context).likes[index] = SocialCubit.get(context).likes[index] + 1;
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                      SocialCubit.get(context).isLiked[index] = true;
                    }
                },
                child: Container(
                  width: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        SocialCubit.get(context).isLiked[index] == false? IconBroken.Heart : Icons.favorite,
                        size: 20,
                        color: defaultColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        SocialCubit.get(context).isLiked[index] == false? 'Like' : 'Liked' ,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.grey[700],
                        ),
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
}
