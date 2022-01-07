class ChatUsers {
  String text;
  String secondaryText;
  String image;
  String time;
  String account_Id;
  String friendShipId;

  ChatUsers(
      {required this.friendShipId,
      required this.text,
      required this.secondaryText,
      required this.image,
      required this.time,
      required this.account_Id});
}
