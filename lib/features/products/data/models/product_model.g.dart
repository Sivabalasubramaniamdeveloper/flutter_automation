// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  status: json['status'] as String,
  message: json['message'] as String,
  products: (json['products'] as List<dynamic>)
      .map((e) => ProductData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'products': instance.products.map((e) => e.toJson()).toList(),
    };

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  price: (json['price'] as num?)?.toInt(),
  description: json['description'] as String?,
  category: json['category'] as String?,
  image: json['image'] as String?,
  brand: json['brand'] as String?,
  model: json['model'] as String?,
  color: json['color'] as String?,
  discount: (json['discount'] as num?)?.toInt() ?? 0,
  popular: json['popular'] as bool?,
);

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
      'brand': instance.brand,
      'model': instance.model,
      'color': instance.color,
      'discount': instance.discount,
      'popular': instance.popular,
    };
