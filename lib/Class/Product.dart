class Product{
  String _name= '';
  int _id=0;
  String _image ='';
  String _description = '';
  List<String> _list=[''];


  Product(this._name, this._id, this._image, this._description, this._list);

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  List<String> get list => _list;

  set list(List<String> value) {
    _list = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['name'] ?? '',
      json['id'] ?? 0,
      json['image'] ?? '',
      json['description'] ?? '',
      (json['list'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [''],
    );
  }

}