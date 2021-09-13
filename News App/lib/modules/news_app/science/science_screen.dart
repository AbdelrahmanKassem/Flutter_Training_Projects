import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/news_app/cubit/cubit.dart';
import 'package:my_first_app/layout/news_app/cubit/states.dart';
import 'package:my_first_app/shared/components/components.dart';

//News App
class ScienceScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state) {
        List<dynamic>? list = NewsCubit.get(context).science;
        return ConditionalBuilder(
          condition: (list != null)? list.length>0 : false,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index) => defaultArticleItem(list![index],context),
            separatorBuilder: (context,index) => defaultItemSeparation(),
            itemCount: (list != null)? list!.length : 0,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}