import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/news_app/cubit/cubit.dart';
import 'package:my_first_app/layout/news_app/cubit/states.dart';
import 'package:my_first_app/shared/components/components.dart';

//News App
class SearchScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state) {
        List<dynamic>? list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultTextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    lableText: 'Search',
                    prefixIcon: Icons.search,
                    onChanged: (String value){
                      print(value);
                      NewsCubit.get(context).getSearch(value);
                      //List<dynamic>? list = NewsCubit.get(context).search;
                    },
                    validator: (String? data)
                    {
                      if(data == null || data!.isEmpty)
                        {
                          return 'Search is empty.';
                        }
                      return null;
                    }
                ),
              ),

              ConditionalBuilder(
                condition: state is! NewsGetSearchLoadingState,
                builder: (context) => Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index) => defaultArticleItem(list![index],context),
                    separatorBuilder: (context,index) => defaultItemSeparation(),
                    itemCount: (list != null)? list!.length : 0,
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      },
    );
  }

}