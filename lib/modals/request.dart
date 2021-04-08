class Request{

  String shopKeeperUid;
  String userUid;
  int number; //type
  int amount; //kitna
  int price; // total dc + ch
  bool accepted;
  int expectedTime;


  Request({this.shopKeeperUid, this.userUid, this.number, this.amount, this.price,this.accepted,this.expectedTime});

}