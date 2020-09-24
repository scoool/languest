class SQLiteWords {

  int _id;
  String _word;
  String _mean;
  String _lang;

  SQLiteWords(this._id, this._word, this._mean,this._lang);


  SQLiteWords.withid(this._id, this._word, this._mean,this._lang);

  int get id => _id;
  String get word => _word;
  String get mean => _mean;
  String get lang => _lang;

  set word(String newWord) {
    if (newWord.length <= 2) {
      this._word = newWord;
    }
  }

  set mean(String newMean) {
    if (newMean.length <= 2) {
      this._mean = newMean;
    }
  }

  set lang(String newLang) {
    if (newLang.length <= 2) {
      this._lang = newLang;
    }
  }

   // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['word'] = _word;
    map['mean'] = _mean;
    map['lang'] = _lang;

    return map;
  }

  // Extract a Note object from a Map object
  SQLiteWords.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._word = map['word'];
    this._mean = map['mean'];
    this._lang = map['lang'];
  }
}