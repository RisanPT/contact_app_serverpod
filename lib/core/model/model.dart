
import 'package:freezed_annotation/freezed_annotation.dart';

part "model.freezed.dart";
part "model.g.dart";

@freezed

class ContactModel with _$ContactModel{
  factory ContactModel({
    required int  id,
    required String name,
    required String mobile,

  })=_ContactModel;
  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);
}