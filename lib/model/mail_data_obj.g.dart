// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_data_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailDataObj _$MailDataObjFromJson(Map<String, dynamic> json) => MailDataObj(
      json['from'] as String,
      json['to'] as String,
      json['cc'] as String,
      json['content'] as String,
      json['sentDate'] == null
          ? null
          : DateTime.parse(json['sentDate'] as String),
    );

Map<String, dynamic> _$MailDataObjToJson(MailDataObj instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'cc': instance.cc,
      'content': instance.content,
      'sentDate': instance.sentDate?.toIso8601String(),
    };
