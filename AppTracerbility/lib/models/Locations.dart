class Locations{
  final int id;
  final String nameLocation;

  Locations({this.id, this.nameLocation});

  factory Locations.fromJson(Map<String, dynamic> map){
    return Locations(
      id: map['idLocation'],
      nameLocation: map['location1']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'idLocation': id,
      'location1':nameLocation
    };
  }
}