class ShopLoginModel
{
  bool? status;
  String? messege;
  UserModel? data;

  ShopLoginModel.fromJson({
    required Map<String,dynamic> json,
}){
    status = json['status'];
    messege = json['messege'];
    data = json['data'] != null ? UserModel.fromJson(json: json['data']) : null;
  }
}

class UserModel
{
  int? id;
  String? name;
  String? email;
  String? image;
  String? phone;
  int? points;
  int? credit;
  String? token;

  UserModel.fromJson({
    required Map<String,dynamic> json,
}){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}