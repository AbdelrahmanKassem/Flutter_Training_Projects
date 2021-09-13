import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences? sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static putBool({
    required String key,
    required bool value,
}) async
  {
    return await sharedPreferences!.setBool(key, value);
  }

  static bool? getBool({
    required String key,
  })
  {
    return sharedPreferences?.getBool(key);
  }

  static setData({
    required String key,
    required value,
})async
  {
    if(value is bool) return await sharedPreferences!.setBool(key, value);
    else if(value is int) return await sharedPreferences!.setInt(key, value);
    else if(value is String) return await sharedPreferences!.setString(key, value);
    else if(value is double) return await sharedPreferences!.setDouble(key, value);
    else if(value is List<String>) return await sharedPreferences!.setStringList(key, value);
  }

  static dynamic getData({
    required String key,
})
  {
    return sharedPreferences?.get(key);
  }

  static removeData({
    required String key,
  }) async
  {
    return await sharedPreferences!.remove(key,);
  }
}

