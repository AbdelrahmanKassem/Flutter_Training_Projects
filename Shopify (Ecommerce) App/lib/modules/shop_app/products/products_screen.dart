import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/shop_app/cubit/cubit.dart';
import 'package:my_first_app/layout/shop_app/cubit/states.dart';
import 'package:my_first_app/models/user/shop_app/shop_categories_model.dart';
import 'package:my_first_app/models/user/shop_app/shop_home_model.dart';
import 'package:my_first_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {
        if(state is ShopSuccessFavoritesState)
          {

            if(state.model!.status == false)
              {
                showToast(
                    messege: state.model!.messege.toString(),
                    state: ToastState.ERROR,
                );
              }
            else
              {
                showToast(
                  messege: state.model!.messege.toString(),
                  state: ToastState.SUCCESS,
                );
              }
          }
      },
      builder: (context,state) => ConditionalBuilder(
        condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
        builder: (context) => ProductBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
        fallback: (context) => Center(child: CircularProgressIndicator()),

      ),
    );
  }

  Widget ProductBuilder(HomeModel? homeModel,CategoriesModel? categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: homeModel!.data!.banners.map((e) => Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              reverse: false,
              scrollDirection: Axis.horizontal,
              height: 250,
              initialPage: 0,
            ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            'Categories',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2),
          height: 100,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index) => buildCategoryItem(categoriesModel!.data!.data[index]),
            separatorBuilder: (context,index) => SizedBox(
              width: 8,
            ),
            itemCount: categoriesModel!.data!.data.length,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            'New Products',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.65,
            children: List.generate(
              homeModel.data!.products.length,
              (index) => buildGridProduct(homeModel.data!.products[index],context),
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildCategoryItem(DataModel model) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
          fit: BoxFit.cover,
          height: 100,
          width: 100,
          image: NetworkImage('${model.image}')
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100,
        child: Text(
          '${model.name}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(ProductsModel productsModel, context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              height: 200,
              image: NetworkImage('${productsModel.image}'),
              width: double.infinity,
            ),
            if(productsModel.discount != 0)
            Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                child: Text(
                  '${productsModel.discount.round()}% OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 35,
                child: Text(
                  '${productsModel.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${productsModel.price.round()} LE',
                    style: TextStyle(
                      fontSize: 16,
                      color: defaultColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ConditionalBuilder(
                    condition: productsModel.discount != 0 && productsModel.price < productsModel.oldPrice,
                    builder: (context) => Text(
                      '${productsModel.oldPrice.round()} LE',
                      style: TextStyle(
                        fontSize: 10,
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
                      alignment: AlignmentDirectional.bottomEnd,
                      iconSize: 24,
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(productsModel.id);
                      },
                      icon: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Icon(
                          ShopCubit.get(context).favorites![productsModel.id] == true ? Icons.favorite :Icons.favorite_border,
                          color: ShopCubit.get(context).favorites![productsModel.id] == true ? defaultColor : Colors.grey[800],
                        ),
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}