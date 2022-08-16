// ignore_for_file: constant_identifier_names

const String ProductId = 'id';
const String ProductName = 'name';
const String ProductCategory = 'category';
const String ProductDescripton = 'descripton';
const String ProductSalePrice = 'salePrice';
const String ProductFeatured = 'featured';
const String ProductAvailable = 'available';
const String ProductImageUrl = 'imageUrl';

class ProductModel {
  String? id;
  String? name;
  String? category;
  String? descripton;
  num salePrice;
  bool featured;
  bool available;
  String? imageUrl;

  ProductModel({
    this.id,
    this.name,
    this.category,
    this.descripton,
    required this.salePrice,
    this.featured = true,
    this.available = true,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ProductId: id,
      ProductName: name,
      ProductCategory: category,
      ProductDescripton: descripton,
      ProductSalePrice: salePrice,
      ProductFeatured: featured,
      ProductAvailable: available,
      ProductImageUrl: imageUrl,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
    id: map[ProductId],
    name: map[ProductName],
    category: map[ProductCategory],
    descripton: map[ProductDescripton],
    salePrice: map[ProductSalePrice],
    featured: map[ProductFeatured],
    available: map[ProductAvailable],
    imageUrl: map[ProductImageUrl],
  );
}
