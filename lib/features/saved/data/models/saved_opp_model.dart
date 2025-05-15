// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';

class SavedOppModel {
  int id;
  int oppId;
  int userid;
  OpportunityModel opp;
  SavedOppModel({
    required this.id,
    required this.oppId,
    required this.userid,
    required this.opp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'oppId': oppId,
      'userid': userid,
      'opp': opp.toMap(),
    };
  }

  factory SavedOppModel.fromMap(Map<String, dynamic> map) {
    return SavedOppModel(
      id: map['id'] as int,
      oppId: map['oppId'] as int,
      userid: map['userid'] as int,
      opp: OpportunityModel.fromMap(map['opp'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SavedOppModel.fromJson(String source) =>
      SavedOppModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
