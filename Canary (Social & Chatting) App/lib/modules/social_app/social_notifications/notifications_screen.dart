import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(
        'Notifications will appear here',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 18,

      ),
    ));
  }
}
