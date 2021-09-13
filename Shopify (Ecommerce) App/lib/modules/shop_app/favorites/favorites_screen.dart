import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/shop_app/cubit/cubit.dart';
import 'package:my_first_app/layout/shop_app/cubit/states.dart';
import 'package:my_first_app/models/user/shop_app/shop_favorites_model.dart';
import 'package:my_first_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopCubit,ShopStates>(
      listener: (context,states){},
      builder: (context,states) {
        if(ShopCubit.get(context).favoritesModel == null)
        {
          ShopCubit.get(context).getFavoritesData();
        }
        return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ConditionalBuilder(
          condition: ShopCubit.get(context).favoritesModel?.data?.data.length != null && ShopCubit.get(context).favoritesModel!.data!.data.length != 0,
          builder: (context) => states is ShopLoadingGetFavoritesState? Center(child: CircularProgressIndicator()) : Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
                itemBuilder: (context,index) => buildFavoriteItem(ShopCubit.get(context).favoritesModel!.data!.data[index] , context),
                separatorBuilder: (context,index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 12),
                  child: Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 0.5,
                  ),
                ),
                itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
            ),
          ),
          fallback: (context) => Center(
              child: Text(
                  'Items marked as favorite will appear here.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
          ),
        ),
      );
      },
    );
  }

  Widget buildFavoriteItem(Products model , context) => Container(
    height: 105,
    width: double.infinity,
    color: Colors.white,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${model.product!.image}')
                ),
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
            ),

              if(model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    child: Text(
                      '${model.product!.discount!.round()}% OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.product!.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.product!.price} LE',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.3,
                        color: defaultColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ConditionalBuilder(
                      condition: model.product!.discount != 0 && model.product!.price < model.product!.oldPrice,
                      builder: (context) => Text(
                        '${model.product!.oldPrice} LE',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 24,
                        onPressed: ()
                        {
                          ShopCubit.get(context).changeFavorites(model.product!.id);
                        },
                        icon: Icon(
                          ShopCubit.get(context).favorites![model.product!.id] == true ? Icons.favorite :Icons.favorite_border,
                          color: ShopCubit.get(context).favorites![model.product!.id] == true ? defaultColor : Colors.grey[800],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

}