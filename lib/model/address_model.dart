// ignore_for_file: constant_identifier_names

const String AdStreetAddress = 'streetAddress';
const String AdArea = 'area';
const String AdCity = 'city';
const String AdZipCode = 'zipCode';

class AddressModel {
  String streetAddress;
  String area;
  String city;
  int zipCode;

  AddressModel(
      {required this.streetAddress,
      required this.area,
      required this.city,
      required this.zipCode});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      AdStreetAddress: streetAddress,
      AdArea: area,
      AdCity: city,
      AdZipCode: zipCode,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      streetAddress: map[AdStreetAddress],
      area: map[AdArea],
      city: map[AdCity],
      zipCode: map[AdZipCode],
    );
  }
}
