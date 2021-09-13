import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/shop_app/cubit/cubit.dart';
import 'package:my_first_app/models/user/shop_app/shop_search_model.dart';
import 'package:my_first_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:my_first_app/modules/shop_app/search/cubit/states.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, states) {},
        builder: (context, states) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                defaultTextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    lableText: 'Search',
                    prefixIcon: Icons.search,
                    validator: (value){
                      if(value == null || value.isEmpty)
                      {
                        return 'Search is Empty';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value){
                      ShopSearchCubit.get(context).getUserSearch(text: value);
                    }
                ),
                SizedBox(
                  height: 10,
                ),
                if(states is ShopSearchLoadingState) LinearProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                if(states is ShopSearchSuccessState)
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context,index) => buildSearchItem(ShopSearchCubit.get(context).searchModel.data!.data[index],context),
                    separatorBuilder: (context,index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 12),
                      child: Container(
                        color: Colors.grey,
                        width: double.infinity,
                        height: 0.5,
                      ),
                    ),
                    itemCount: ShopSearchCubit.get(context).searchModel.data!.data.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchItem(ProductData model , context) => Container(
    height: 105,
    width: double.infinity,
    color: Colors.white,
    child: Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('${model.image}')
            ),
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
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
                  '${model.name}',
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
                      '${model.price} LE',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.3,
                        color: defaultColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 24,
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: Icon(
                        ShopCubit.get(context).favorites![model.id] == true ? Icons.favorite :Icons.favorite_border,
                        color: ShopCubit.get(context).favorites![model.id] == true ? defaultColor : Colors.grey[800],
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