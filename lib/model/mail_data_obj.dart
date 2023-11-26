import 'package:json_annotation/json_annotation.dart';

part 'mail_data_obj.g.dart';
@JsonSerializable()
class MailDataObj {
   /// The generated code assumes these values exist in JSON.
  final String from;
  final String to;
    final String cc;
  final String content;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  final DateTime? sentDate;

  MailDataObj(this.from, this.to, this.cc, this.content, this.sentDate);

  factory MailDataObj.fromJson(Map<String, dynamic> json) => _$MailDataObjFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$MailDataObjToJson`.
  Map<String, dynamic> toJson() => _$MailDataObjToJson(this);
}