class User {
  String _username = '';
  String _pfp = '';
  String _name = '';
  List<int> _created_products_id = [];

  User(this._username, this._pfp, this._name, this._created_products_id);

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


  List<int> get created_products_id => _created_products_id;

  set created_products_id(List<int> value) {
    _created_products_id = value;
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      json['username'] as String,
      json['pfp'] as String,
      json['name'] as String,
      json['created_products_id'] != null
          ? List<int>.from(json['created_products_id'])
          : <int>[],
    );
  }
}
