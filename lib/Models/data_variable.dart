class Variables{
  static final Variables _singleton = Variables._internal();

  factory Variables() {
    return _singleton;
  }

  Variables._internal();

  int _idOfList;
  List<String> _categories;
  ///have : today, tomorrow, temporary(is status)
  Map<String,int> _tasks;

  setTask(String name, int value){
    this._tasks[name]=value;
  }
  updateTask(String name,val){
    this._tasks.update(name, (value) => val);
  }
  int getNum(String name){
    return this._tasks[name];
  }
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