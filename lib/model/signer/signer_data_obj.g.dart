// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signer_data_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignerDataObj _$SignerDataObjFromJson(Map<String, dynamic> json) =>
    SignerDataObj(
      json['subjectDN'] as String,
      json['issuerDN'] as String,
      DateTime.parse(json['validityFrom'] as String),
      DateTime.parse(json['validityTo'] as String),
    );

Map<String, dynamic> _$SignerDataObjToJson(SignerDataObj instance) =>
    <String, dynamic>{
      'subjectDN': instance.subjectDN,
      'issuerDN': instance.issuerDN,
      'validityFrom': instance.validityFrom.toIso8601String(),
      'validityTo': instance.validityTo.toIso8601String(),
    };
