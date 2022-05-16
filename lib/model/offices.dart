import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'offices.g.dart';

@JsonSerializable()
class OfficesList {
  List<Office> offices;

  OfficesList({required this.offices});

  factory OfficesList.fromJson(Map<String, dynamic> json) =>
      _$OfficesListFromJson(json);

  Map<String, dynamic> toJson() => _$OfficesListToJson(this);

  // factory OfficesList.fromJson(Map<String, dynamic> json) {
  //   var officesJson = json['offices'] as List;

  //   List<Office> officesList =
  //       officesJson.map((i) => Office.fromJson(i)).toList();

  //   return (OfficesList(offices: officesList));
  // }
}

@JsonSerializable()
class Office {
  Office({required this.name, required this.address, required this.image});

  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final String address;

  @JsonKey(required: true)
  final String image;

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  // factory Office.fromJson(Map<String, dynamic> json) {
  //   return Office(
  //       name: json['name'] as String,
  //       address: json['address'] as String,
  //       image: json['image'] as String);
  // }
}

Future<OfficesList> getOfficesList() async {
  const url = 'https://about.google.com/static/data/locations.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return OfficesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
