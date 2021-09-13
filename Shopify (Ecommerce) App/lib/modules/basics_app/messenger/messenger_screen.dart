import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messengerscreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 15,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://scontent.fcai20-3.fna.fbcdn.net/v/t1.6435-9/130556088_3489845371100480_9192938430297165753_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=wQQMn_ayWCoAX8Xy3yi&_nc_ht=scontent.fcai20-3.fna&oh=c6bb926d4b7388e47ebc6a1b195b0092&oe=6128E12D'),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Chats',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey.shade200,
            child: IconButton(
              iconSize: 16,
              color: Colors.black,
                onPressed: (){
                  print('Camera');
                },
                icon: Icon(Icons.camera_alt),
            ),
          ),
          SizedBox(
            width: 6,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.bottom,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 95,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context , index){
                          return buildStoryItem();
                        },
                        separatorBuilder: (context , index){
                          return SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: 10,
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context , index){
                      return buildChatItem();
                    },
                    separatorBuilder: (context , index){
                      return SizedBox(
                        height: 13,
                      );
                    },
                    itemCount: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

Widget buildChatItem () => Row(
  children: [
    Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://scontent.fcai20-3.fna.fbcdn.net/v/t1.6435-9/130556088_3489845371100480_9192938430297165753_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=wQQMn_ayWCoAX8Xy3yi&_nc_ht=scontent.fcai20-3.fna&oh=c6bb926d4b7388e47ebc6a1b195b0092&oe=6128E12D'),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 8,
        ),
        CircleAvatar(
          backgroundColor: Colors.green,
          radius: 7,
        ),
      ],
    ),
    SizedBox(
      width: 13,
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Abdelrahman Kassem',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'My name is Kassem and I want to',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              Text(
                '02:00 PM',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    ),
  ],
);

Widget buildStoryItem() => Container(
  width: 60,
  child: Column(
    children: [
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage('https://scontent.fcai20-3.fna.fbcdn.net/v/t1.6435-9/130556088_3489845371100480_9192938430297165753_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=wQQMn_ayWCoAX8Xy3yi&_nc_ht=scontent.fcai20-3.fna&oh=c6bb926d4b7388e47ebc6a1b195b0092&oe=6128E12D'),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 8,
          ),
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 7,
          ),
        ],
      ),
      SizedBox(
        height: 3,
      ),
      Text(
        'Abdelrahman Kassem',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  ),
);