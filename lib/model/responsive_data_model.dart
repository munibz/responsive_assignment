// To parse this JSON data, do
//
//     final responsiveData = responsiveDataFromJson(jsonString);

import 'dart:convert';

ResponsiveData responsiveDataFromJson(String str) =>
    ResponsiveData.fromJson(json.decode(str));

String responsiveDataToJson(ResponsiveData data) => json.encode(data.toJson());

class ResponsiveData {
  final String name;
  final String location;
  final String profilephoto;
  final int yoe;
  final int projects;
  final int clients;
  final String aboutUser;

  ResponsiveData({
    required this.name,
    required this.location,
    required this.profilephoto,
    required this.yoe,
    required this.projects,
    required this.clients,
    required this.aboutUser,
  });

  ResponsiveData copyWith({
    String? name,
    String? location,
    String? profilephoto,
    int? yoe,
    int? projects,
    int? clients,
    String? aboutUser,
  }) =>
      ResponsiveData(
        name: name ?? this.name,
        location: location ?? this.location,
        profilephoto: profilephoto ?? this.profilephoto,
        yoe: yoe ?? this.yoe,
        projects: projects ?? this.projects,
        clients: clients ?? this.clients,
        aboutUser: aboutUser ?? this.aboutUser,
      );

  factory ResponsiveData.fromJson(Map<String, dynamic> json) => ResponsiveData(
        name: json["name"],
        location: json["location"],
        profilephoto: json["profilephoto"],
        yoe: json["yoe"],
        projects: json["projects"],
        clients: json["clients"],
        aboutUser: json["aboutUser"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "profilephoto": profilephoto,
        "yoe": yoe,
        "projects": projects,
        "clients": clients,
        "aboutUser": aboutUser,
      };
}
