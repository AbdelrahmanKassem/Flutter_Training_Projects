import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/shop_app/cubit/cubit.dart';
import 'package:my_first_app/layout/shop_app/cubit/states.dart';
import 'package:my_first_app/models/user/shop_app/shop_categories_model.dart';

class CategoriesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,states){},
      builder: (context,states) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index) => buildCategoryItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context,index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 12),
              child: Container(
                color: Colors.grey,
                width: double.infinity,
                height: 0.5,
              ),
            ),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        ),
      ),
    );
  }

  Widget buildCategoryItem(DataModel model)
  {
    return Row(
      children: [
        Image(
          width: 80,
          height: 80,
          image: NetworkImage('${model.image}')
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    );
  }
}