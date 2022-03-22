class User {
  int birthyear;
  String email, password, nickname, country;

  User({this.email, this.password, this.nickname, this.country, this.birthyear});

  Map<String, dynamic> getUser() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['nickname'] = nickname;
    map['country'] = country;
    map['birthyear'] = birthyear;
    return map;
  }
}