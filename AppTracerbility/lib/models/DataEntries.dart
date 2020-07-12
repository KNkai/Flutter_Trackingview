import 'dart:convert';

class DataEntries{
  String id;
  String startDate;
  String endDate;
  int idLocation;

  DataEntries({this.id, this.startDate, this.endDate, this.idLocation});

  factory DataEntries.fromJson(Map<String, dynamic> map){
    return DataEntries(
      id : map['idDataEntry'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      idLocation: map['idLocation'] 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idDataEntry": id, 
      "startDate": startDate, 
      "endDate": endDate, 
      "idLocation": idLocation
    };
  }

  @override
  String toString() {
    return 'DataEntries{idDataEntry: $id, startDate: $startDate, endDate: $endDate, idLocation: $idLocation}';
  }

  List<DataEntries> dataEntriesFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<DataEntries>.from(data.map((item) => DataEntries.fromJson(item)));
  }

  String dataEntriesToJson(DataEntries data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }

}