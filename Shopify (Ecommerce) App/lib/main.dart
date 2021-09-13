import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_first_app/layout/shop_app/cubit/cubit.dart';
import 'package:my_first_app/layout/shop_app/shop_layout.dart';
import 'package:my_first_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:my_first_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:my_first_app/shared/bloc_observer.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/cubit/cubit.dart';
import 'package:my_first_app/shared/cubit/states.dart';
import 'package:my_first_app/shared/network/local/cache_helper.dart';
import 'package:my_first_app/shared/network/remote/dio_helper.dart';
import 'package:my_first_app/shared/styles/themes.dart';


void main() async {
  //Byt2aked bl command da en kol 7aga abl el runApp lazm te5las el awal
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget startWidget;

  bool? onBoarding = CacheHelper.getData(key: 'BoardingDoneFlag');
  token = CacheHelper.getData(key: 'token');
  if(onBoarding != null)
    {
      if(token != null)
        {
          startWidget = ShopLayout();
        }
      else
        {
         startWidget = ShopLoginScreen();
        }
    }
  else
    {
      startWidget = OnBoardingScreen();
    }

  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget
{
  Widget startWidget;
  MyApp(this.startWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit(),),
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark:ThemeMode.light,
            home: Directionality(
                textDirection: TextDirection.ltr,
                child: startWidget,
            ),
          );
        },
      ),
    );
  }
}
