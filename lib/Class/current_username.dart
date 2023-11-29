class CurrentUsername{
  String _currentusername ='-1';

  CurrentUsername(this._currentusername);

  String get currentusername => _currentusername;

  set currentusername(String value) {
    _currentusername = value;
  }
}

CurrentUsername currentUsername = CurrentUsername('-1');