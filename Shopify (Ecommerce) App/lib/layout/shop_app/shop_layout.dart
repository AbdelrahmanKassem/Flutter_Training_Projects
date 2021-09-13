import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/shop_app/cubit/cubit.dart';
import 'package:my_first_app/layout/shop_app/cubit/states.dart';
import 'package:my_first_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:my_first_app/modules/shop_app/search/search_screen.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/network/local/cache_helper.dart';
import 'package:my_first_app/shared/styles/colors.dart';

class ShopLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {},
      builder:(context,state) => Scaffold(
        appBar: AppBar(
          elevation: 10,
          actions: [
            IconButton(
              onPressed: (){
                navigateTo(context, SearchScreen());
              },
              icon: Icon(
                  Icons.search
              ),
            ),
          ],
          title: Text(
            'SHOPIFY',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: defaultColor,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.2,
              fontSize: 26,
            ),
          ),
        ),
        body: cubit.bottomScreens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          onTap: (index){
            cubit.changeNavBar(index);
          },
          currentIndex: cubit.currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.table_rows_sharp,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

}