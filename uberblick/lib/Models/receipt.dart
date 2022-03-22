class Receipt {
  int userId;
  String dateTime, location, foodIds;

  Receipt({this.userId, this.foodIds, this.dateTime, this.location});

  Map<String, dynamic> getReceipt() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['food_ids'] = foodIds;
    map['date_time'] = dateTime;
    map['location'] = location;
    return map;
  }
}