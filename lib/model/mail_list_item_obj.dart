import 'package:json_annotation/json_annotation.dart';

part 'mail_list_item_obj.g.dart';
@JsonSerializable()
class MailListItemDataObj {
   /// The generated code assumes these values exist in JSON.
   String avatar;
   String sender;
   String subject;
   String content;
   String type;
   bool isStared;
  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
   DateTime? sentDate;

  MailListItemDataObj(this.avatar, this.sender, this.subject, this.content, this.type, this.isStared,this.sentDate);

  factory MailListItemDataObj.fromJson(Map<String, dynamic> json) => _$MailListItemDataObjFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$MailDataObjToJson`.
  Map<String, dynamic> toJson() => _$MailListItemDataObjToJson(this);
}