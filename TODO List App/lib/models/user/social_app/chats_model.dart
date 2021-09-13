class ChatsModel
{
  String? text;
  String? receiverId;
  String? senderId;
  String? dateTime;

  ChatsModel({
    required this.text,
    required this.receiverId,
    required this.senderId,
    required this.dateTime,
  });
  ChatsModel.fromJSON(Map<String,dynamic> json)
  {
    text = json['text'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'text' : text,
      'receiverId' : receiverId,
      'senderId' : senderId,
      'dateTime' : dateTime,
    };
  }
}