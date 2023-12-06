import 'package:json_annotation/json_annotation.dart';

part 'signer_data_obj.g.dart';
@JsonSerializable()
class SignerDataObj {
  final String subjectDN;
  final String issuerDN;
  final DateTime validityFrom;
  final DateTime validityTo;

  SignerDataObj(this.subjectDN, this.issuerDN, this.validityFrom, this.validityTo);


  factory SignerDataObj.fromJson(Map<String, dynamic> json) => _$SignerDataObjFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$MailDataObjToJson`.
  Map<String, dynamic> toJson() => _$SignerDataObjToJson(this);
}