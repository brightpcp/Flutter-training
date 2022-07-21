// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
        required this.context,
        required this.id,
        required this.type,
        required this.hydraMember,
        required this.hydraTotalItems,
    });

    String context;
    String id;
    String type;
    List<HydraMember> hydraMember;
    int hydraTotalItems;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        context: json["@context"],
        id: json["@id"],
        type: json["@type"],
        hydraMember: List<HydraMember>.from(json["hydra:member"].map((x) => HydraMember.fromJson(x))),
        hydraTotalItems: json["hydra:totalItems"],
    );

    Map<String, dynamic> toJson() => {
        "@context": context,
        "@id": id,
        "@type": type,
        "hydra:member": List<dynamic>.from(hydraMember.map((x) => x.toJson())),
        "hydra:totalItems": hydraTotalItems,
    };
}

class HydraMember {
    HydraMember({
        required this.id,
        required this.type,
        required this.hydraMemberId,
        required this.username,
        required this.roles,
        required this.password,
        required this.userIdentifier,
    });

    String id;
    String type;
    int hydraMemberId;
    String username;
    List<String> roles;
    String password;
    String userIdentifier;

    factory HydraMember.fromJson(Map<String, dynamic> json) => HydraMember(
        id: json["@id"],
        type: json["@type"],
        hydraMemberId: json["id"],
        username: json["username"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        password: json["password"],
        userIdentifier: json["userIdentifier"],
    );

    Map<String, dynamic> toJson() => {
        "@id": id,
        "@type": type,
        "id": hydraMemberId,
        "username": username,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "password": password,
        "userIdentifier": userIdentifier,
    };
}
