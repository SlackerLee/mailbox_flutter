import 'package:json_annotation/json_annotation.dart';

part 'address_book_detail_item_obj.g.dart';

@JsonSerializable()
class AddressBookDetailItemDataObj {
  /// The generated code assumes these values exist in JSON.
   String name;
   String emailAddress;
   String title;
   String phone;
   String department;
   
  AddressBookDetailItemDataObj(this.name, this.emailAddress, this.title, this.phone, this.department);

  factory AddressBookDetailItemDataObj.fromJson(Map<String, dynamic> json) =>
      _$AddressBookDetailItemDataObjFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$MailDataObjToJson`.
  Map<String, dynamic> toJson() => _$AddressBookDetailItemDataObjToJson(this);
}
