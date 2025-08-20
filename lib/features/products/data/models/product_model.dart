import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel extends Equatable {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'products')
  final List<ProductData> products;

  const ProductModel({
    required this.status,
    required this.message,
    required this.products,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  List<Object?> get props => [status, message, products];
}

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class ProductData extends Equatable {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'price')
  final int? price; // keeping num because JSON can return int or double

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'brand')
  final String? brand;

  @JsonKey(name: 'model')
  final String? model;

  @JsonKey(name: 'color')
  final String? color;

  @JsonKey(name: 'discount', defaultValue: 0)
  final int? discount;

  @JsonKey(name: 'popular')
  final bool? popular;

  const ProductData({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.brand,
    this.model,
    this.color,
    this.discount = 0,
    this.popular,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataToJson(this);

  @override
  List<Object?> get props => [
    id,
    title,
    price,
    description,
    category,
    image,
    brand,
    model,
    color,
    discount,
    popular,
  ];
}
