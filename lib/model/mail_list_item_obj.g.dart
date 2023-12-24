// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_list_item_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailListItemDataObj _$MailListItemDataObjFromJson(Map<String, dynamic> json) =>
    MailListItemDataObj(
      json['avatar'] as String,
      json['sender'] as String,
      json['subject'] as String,
      json['content'] as String,
      json['type'] as String,
      json['isStared'] as bool,
      json['sentDate'] == null
          ? null
          : DateTime.parse(json['sentDate'] as String),
    );

Map<String, dynamic> _$MailListItemDataObjToJson(
        MailListItemDataObj instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'sender': instance.sender,
      'subject': instance.subject,
      'content': instance.content,
      'type': instance.type,
      'isStared': instance.isStared,
      'sentDate': instance.sentDate?.toIso8601String(),
    };
