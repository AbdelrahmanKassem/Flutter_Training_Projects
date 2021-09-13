class ChangeFavoritesModel
{
  bool? status;
  String? messege;

  ChangeFavoritesModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    messege = json['message'];
  }
}