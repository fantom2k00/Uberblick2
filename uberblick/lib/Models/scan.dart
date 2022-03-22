class Scan {
  int userId, foodId;
  String dateTime, location;

  Scan({this.userId, this.foodId, this.dateTime, this.location});

  Map<String, dynamic> getScan() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['food_id'] = foodId;
    map['date_time'] = dateTime;
    map['location'] = location;
    return map;
  }
}