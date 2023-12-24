import 'package:json_annotation/json_annotation.dart';

part 'mail_data_obj.g.dart';

@JsonSerializable()
class MailDataObj {
  /// The generated code assumes these values exist in JSON.
   String from;
   String to;
   String cc;
   String bcc;
   String type;
   String subject;
   String content;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
   DateTime? sentDate;

  MailDataObj(this.from, this.to, this.cc, this.bcc,this.type, this.subject,this.sentDate, this.content);

  factory MailDataObj.fromJson(Map<String, dynamic> json) =>
      _$MailDataObjFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$MailDataObjToJson`.
  Map<String, dynamic> toJson() => _$MailDataObjToJson(this);
}
