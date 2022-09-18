// ignore_for_file: constant_identifier_names

const String ProductId = 'id';
const String ProductName = 'name';
const String ProductCategory = 'category';
const String ProductDescripton = 'descripton';
const String ProductSalePrice = 'salePrice';
const String ProductFeatured = 'featured';
const String ProductAvailable = 'available';
const String ProductImageUrl = 'imageUrl';
const String ProductStock = 'stock';
const String ProductRating = 'rating';

class ProductModel {
  String? id;
  String? name;
  String? category;
  String? descripton;
  num salePrice;
  num? stock;
  bool featured;
  bool available;
  String? imageUrl;
  double rating;

  ProductModel({
    this.id,
    this.name,
    this.category,
    this.descripton,
    required this.salePrice,
    this.featured = true,
    this.available = true,
    this.imageUrl,
    this.stock = 10,
    this.rating = 0.0,
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
      ProductStock: stock,
      ProductRating: rating,
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
    stock: map[ProductStock] ?? 10,
    rating: map[ProductRating] ?? 0.0,
  );
}
