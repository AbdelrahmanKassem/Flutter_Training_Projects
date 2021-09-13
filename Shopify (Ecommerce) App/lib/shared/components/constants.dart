import 'package:my_first_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:my_first_app/shared/network/local/cache_helper.dart';
import 'components.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value){
    navigateAndFinish(context, ShopLoginScreen());
  });
}

String? token = '';

String? uId; //Social App