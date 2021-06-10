class Variables{
  static final Variables _singleton = Variables._internal();

  factory Variables() {
    return _singleton;
  }

  Variables._internal();

  int _idOfList;
  List<String> _categories;
  setCat(List<String> cat){
    this._categories = cat;
  }
  List<String> getCat(){
    return this._categories;
  }

  setData(int value){
    this._idOfList = value;
  }
  getData(){
    return this._idOfList;
  }


}