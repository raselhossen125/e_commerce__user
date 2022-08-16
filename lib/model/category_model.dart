// ignore_for_file: constant_identifier_names, camel_case_types

const String CategoryId = 'catId';
const String CategoryName = 'catName';
const String CategoryProductCount = 'count';
const String CategoryAvailable = 'available';

class CategoryModel {
  String? catId;
  String? catName;
  num count;
  bool available;

  CategoryModel({
    this.catId,
    this.catName,
    this.count = 0,
    this.available = true,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CategoryId: catId,
      CategoryName: catName,
      CategoryProductCount: count,
      CategoryAvailable: available,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) => CategoryModel(
    catId: map[CategoryId],
    catName: map[CategoryName],
    count: map[CategoryProductCount],
    available: map[CategoryAvailable],
  );
}
