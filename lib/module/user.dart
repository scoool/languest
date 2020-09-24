class Userid{
  String id;

  Userid({this.id});

  factory Userid.fromJson(Map<String, dynamic> jsonData) {
    return Userid(
      id: jsonData['id'],
    );
  }
}

class User{
  String name,role,password;
  String id;

  User({this.id, this.name, this.role,this.password});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData['id'],
      name: jsonData['name'],
      role: jsonData['role'],
      password: jsonData['password'],
    );
  }
}

class Words{
  final String word,mean,lang;
  Words({ this.word, this.mean, this.lang  });

  factory Words.fromJson(Map<String, dynamic> jsonData) {
    return Words(
      word: jsonData['word'],
      mean: jsonData['mean'],
      lang: jsonData['lang'],
    );
  }
}

class Points{
  final String point_date,points,game,lang;
  Points({ this.point_date, this.points, this.game ,this.lang });

  factory Points.fromJson(Map<String, dynamic> jsonData) {
    return Points(
      point_date: jsonData['point_date'],
      points: jsonData['points'],
      game: jsonData['game'],
      lang: jsonData['lang'],
    );
  }
}