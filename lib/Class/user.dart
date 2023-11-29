class User {
  String _username = '';
  String _pfp = '';
  String _name = '';

  User(this._username, this._pfp, this._name);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get pfp => _pfp;

  set pfp(String value) {
    _pfp = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      json['username'] as String,
      json['pfp'] as String,
      json['name'] as String,
    );
  }
}
