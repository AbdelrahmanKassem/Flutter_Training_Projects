import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: (){
            print('menu');
          },
        ),
        title: Text(
          'My First App',
        ),
        actions: [
          IconButton(
              onPressed: (){
                print('hello');
              },
              icon: Icon(
                Icons.notification_important,
              ),
          ),
          IconButton(
              onPressed: (){
                print('account');
              },
              icon: Icon(
                Icons.account_box,
              ),
          ),

        ],
      ),
      body: SafeArea(
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular( //.only if we want to chane only one edge and make it circular
                    20.0,
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter, //alignment of small widgets in stack
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image(
                      fit: BoxFit.cover, //contain and fill
                      image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_960_720.jpg',
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    width: 200,
                    child: Text(
                      'Flower',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ],
          ),
        )
      );
  }

}