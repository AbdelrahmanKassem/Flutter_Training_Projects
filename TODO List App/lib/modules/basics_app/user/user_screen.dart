import 'package:flutter/material.dart';
import 'package:my_first_app/models/user/user_model.dart';


class Userscreen extends StatelessWidget
{
  List<DataModel> userData = [

    DataModel(
      id: 0,
      name: 'Abdelrahman Kassem',
      phone: '01023005589',
    ),
    DataModel(
      id: 1,
      name: 'Ali Kassem',
      phone: '010230123189',
    ),
    DataModel(
      id: 2,
      name: 'Ahmed Joe',
      phone: '01012315589',
    ),
    DataModel(
      id: 3,
      name: 'Mohamed Jemy',
      phone: '01021121239',
    ),
    DataModel(
      id: 0,
      name: 'Abdelrahman Kassem',
      phone: '01023005589',
    ),
    DataModel(
      id: 1,
      name: 'Ali Kassem',
      phone: '010230123189',
    ),
    DataModel(
      id: 2,
      name: 'Ahmed Joe',
      phone: '01012315589',
    ),
    DataModel(
      id: 3,
      name: 'Mohamed Jemy',
      phone: '01021121239',
    ),
    DataModel(
      id: 0,
      name: 'Abdelrahman Kassem',
      phone: '01023005589',
    ),
    DataModel(
      id: 1,
      name: 'Ali Kassem',
      phone: '010230123189',
    ),
    DataModel(
      id: 2,
      name: 'Ahmed Joe',
      phone: '01012315589',
    ),
    DataModel(
      id: 3,
      name: 'Mohamed Jemy',
      phone: '01021121239',
    ),
    DataModel(
      id: 0,
      name: 'Abdelrahman Kassem',
      phone: '01023005589',
    ),
    DataModel(
      id: 1,
      name: 'Ali Kassem',
      phone: '010230123189',
    ),
    DataModel(
      id: 2,
      name: 'Ahmed Joe',
      phone: '01012315589',
    ),
    DataModel(
      id: 3,
      name: 'Mohamed Jemy',
      phone: '01021121239',
    ),
    DataModel(
      id: 0,
      name: 'Abdelrahman Kassem',
      phone: '01023005589',
    ),
    DataModel(
      id: 1,
      name: 'Ali Kassem',
      phone: '010230123189',
    ),
    DataModel(
      id: 2,
      name: 'Ahmed Joe',
      phone: '01012315589',
    ),
    DataModel(
      id: 3,
      name: 'Mohamed Jemy',
      phone: '01021121239',
    ),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Expanded(
          child: ListView.separated(
            itemBuilder: (context , index){
              return buildUserItem(userData[index]);
            },
            separatorBuilder: (context , index){
              return SizedBox(
                height: 10,
              );
            },
            itemCount: userData.length,
          ),
        ),
      ),
    );
  }

}

Widget buildUserItem (DataModel data) => Row(
  children: [
    CircleAvatar(
      radius: 25,
      child: Text(
        '${data.id}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${data.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '${data.phone}',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 17,
          ),
        ),
      ],
    ),
  ],
);