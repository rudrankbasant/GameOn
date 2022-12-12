class Ground{
  String? id;
  String? name;
  String? img;
  String? location;
  String? pitch_type;
  String? datetime;

  String? team1_20overs;
  String? team2_20overs;
  int? price_20overs;
  bool? ball_provided_20overs;
  bool? umpire_provided_20overs;
  String? ball_detail_20overs;

  String? team1_30overs;
  String? team2_30overs;
  int? price_30overs;
  bool? ball_provided_30overs;
  bool? umpire_provided_30overs;
  String? ball_detail_30overs;


  Ground({
    this.id,
    this.name,
    this.img,
    this.location,
    this.pitch_type,
    this.datetime,
    this.team1_20overs,
    this.team2_20overs,
    this.price_20overs,
    this.ball_provided_20overs,
    this.umpire_provided_20overs,
    this.ball_detail_20overs,
    this.team1_30overs,
    this.team2_30overs,
    this.price_30overs,
    this.ball_provided_30overs,
    this.umpire_provided_30overs,
    this.ball_detail_30overs,
  });


  factory Ground.fromMap(Map<String, dynamic> map){
    return Ground(
        id: map['id'],
        name: map['name'],
        img: map['img'],
        location: map['location'],
        pitch_type: map['pitch_type'],
        datetime: map['datetime'],
        team1_20overs: map['team1_20overs'],
        team2_20overs: map['team2_20overs'],
        price_20overs: map['price_20overs'],
        ball_provided_20overs: map['ball_provided_20overs'],
        umpire_provided_20overs: map['umpire_provided_20overs'],
        ball_detail_20overs: map['ball_detail_20overs'],
        team1_30overs: map['team1_30overs'],
        team2_30overs: map['team2_30overs'],
        price_30overs: map['price_30overs'],
        ball_provided_30overs: map['ball_provided_30overs'],
        umpire_provided_30overs: map['umpire_provided_30overs'],
        ball_detail_30overs: map['ball_detail_30overs'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'location': location,
      'pitch_type': pitch_type,
      'datetime': datetime,
      'team1_20overs': team1_20overs,
      'team2_20overs': team2_20overs,
      'price_20overs': price_20overs,
      'ball_provided_20overs': ball_provided_20overs,
      'umpire_provided_20overs': umpire_provided_20overs,
      'ball_detail_20overs': ball_detail_20overs,
      'team1_30overs': team1_30overs,
      'team2_30overs': team2_30overs,
      'price_30overs': price_30overs,
      'ball_provided_30overs': ball_provided_30overs,
      'umpire_provided_30overs': umpire_provided_30overs,
      'ball_detail_30overs': ball_detail_30overs,
    };
  }

}