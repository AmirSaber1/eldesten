class dataModel {
  int _id;
  String _name;

  dataModel( String _name,int _id) {
    this._id = _id;
    this._name = _name;
  }

  int get_id() {
    return _id;
  }

  void set_id(int _id) {
    this._id = _id;
  }

  String get_name() {
    return _name;
  }

  void set_name(String _name) {
    this._name = _name;
  }
}
