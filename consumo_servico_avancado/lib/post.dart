class Post {
  int _userId;
  int _id;
  String _title;
  String _body;

  Post(this._userId, this._id, this._title, this._body);


  Map toJson(){
    return {
      "userId": this._userId,
      "id": this.id,
      "title": this.title,
      "body": this.body
    };
  }

  // Getters
  int get userId => _userId;
  int get id => _id;
  String get title => _title;
  String get body => _body;

  // Setters
  set userId(int value) {
    _userId = value;
  }

  set id(int value) {
    _id = value;
  }

  set title(String value) {
    _title = value;
  }

  set body(String value) {
    _body = value;
  }
}
