import 'package:fakestoreapi/app/domain/models/Rating.dart';
import 'package:fakestoreapi/app/domain/typedefs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'product.freezed.dart';
part 'product.g.dart';


@Freezed(toJson: true)
class Product with _$Product {
  const factory Product({
    required int id,
    required String title,
    required double price,
    required String description,
    required String image,
    @RatingConverter() required Rating rating,
    String? category,
  }) = _Product;

  const Product._();

  String getFormatted() {
    return '$id $title $price';
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  static List<Product> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => Product.fromJson(json)).toList();

  static List<Map<String, dynamic>> toJsonList(List<Product> products) =>
      products.map((product) => product.toJson()).toList();
}

class RatingConverter implements JsonConverter<Rating, Map<String, dynamic>> {
  const RatingConverter();

  @override
  Rating fromJson(Map<String, dynamic> json) {
    return Rating.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Rating rating) {
    return rating.toJson();
  }
}