class PopularProduct{
  String _name ='';
  int _id = 0;
  double _price = 0.00;
  String _author = '';
  String _gif = '';

  PopularProduct(this._name, this._id, this._price, this._author, this._gif);

  String get author => _author;

  set author(String value) {
    _author = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get gif => _gif;

  set gif(String value) {
    _gif = value;
  }

  factory PopularProduct.fromJson(Map<String, dynamic> json) {
    return PopularProduct(
      json["name"] as String,
      json["id"] as int,
      json["price"] as double,
      json["author"] as String,
      json["gif"] as String,
    );
  }
}