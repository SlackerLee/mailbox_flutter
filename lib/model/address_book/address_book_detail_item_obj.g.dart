// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_book_detail_item_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressBookDetailItemDataObj _$AddressBookDetailItemDataObjFromJson(
        Map<String, dynamic> json) =>
    AddressBookDetailItemDataObj(
      json['name'] as String,
      json['emailAddress'] as String,
      json['title'] as String,
      json['phone'] as String,
      json['department'] as String,
    );

Map<String, dynamic> _$AddressBookDetailItemDataObjToJson(
        AddressBookDetailItemDataObj instance) =>
    <String, dynamic>{
      'name': instance.name,
      'emailAddress': instance.emailAddress,
      'title': instance.title,
      'phone': instance.phone,
      'department': instance.department,
    };
