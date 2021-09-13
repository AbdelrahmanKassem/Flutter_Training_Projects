import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_first_app/layout/social_app/cubit/states.dart';
import 'package:my_first_app/layout/social_app/social_layout.dart';
import 'package:my_first_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:my_first_app/shared/bloc_observer.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/cubit/cubit.dart';
import 'package:my_first_app/shared/network/local/cache_helper.dart';
import 'package:my_first_app/shared/network/remote/dio_helper.dart';
import 'package:my_first_app/shared/styles/themes.dart';
import 'layout/social_app/cubit/cubit.dart';

Future<void> firebaseMessagingBackgroundHandler (RemoteMessage message) async
{
  print(message.data.toString());
  showToast(messege: 'onBackground', state: ToastState.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget startWidget;


  //Social App Part
  uId = CacheHelper.getData(key: 'uId');

  String? messagesToken;
  FirebaseMessaging.instance.getToken().then((value){
    messagesToken = value;
  });

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(messege: 'onMessage', state: ToastState.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(messege: 'onMessageOpenedApp', state: ToastState.SUCCESS);
  });
  
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if(uId != null)
    {
      startWidget = SocialLayout();
    }
  else
    {
      startWidget = SocialLoginScreen();
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
    return BlocProvider(
      create: (context) => SocialCubit(),
      child: BlocConsumer<SocialCubit,SocialState>(
        listener: (context,state) {},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
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
