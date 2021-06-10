class Variables{
  static final Variables _singleton = Variables._internal();

  factory Variables() {
    return _singleton;
  }

  Variables._internal();

  int _idOfList;
  setData(int value){
    this._idOfList = value;
  }
  getData(){
    return this._idOfList;
  }


}