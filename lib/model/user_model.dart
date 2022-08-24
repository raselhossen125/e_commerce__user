// ignore_for_file: prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce__user/model/address_model.dart';

const userUid = 'uId';
const userName = 'name';
const userEmail = 'email';
const userPhone = 'mobile';
const userImage = 'image';
const userAddressModel = 'addressModel';
const userTimeStamp = 'userCreationTime';
const userAvailable = 'available';
const userDeviceToken = 'deviceToken';

class UserModel {
  String uId;
  String? name;
  String email;
  String? mobile;
  String? image;
  AddressModel? addressModel;
  Timestamp userCreationTime;
  bool available;
  String? deviceToken;

  UserModel({
    required this.uId,
    this.name,
    required this.email,
    this.mobile,
    this.image,
    this.addressModel,
    required this.userCreationTime,
    this.available = false,
    this.deviceToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      userUid: uId,
      userName: name,
      userEmail: email,
      userPhone: mobile,
      userImage: image,
      userAddressModel: addressModel,
      userTimeStamp: userCreationTime,
      userAvailable: available,
      userDeviceToken: deviceToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        uId: map[userUid],
        name: map[userName],
        email: map[userEmail],
        mobile: map[userPhone],
        image: map[userImage],
        addressModel: map[userAddressModel] == null
            ? map[userAddressModel]
            : AddressModel.fromMap(map[userAddressModel]),
        userCreationTime: map[userTimeStamp],
        available: map[userAvailable],
        deviceToken: map[userDeviceToken],
      );
}
