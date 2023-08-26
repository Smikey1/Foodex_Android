// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      json['title'] as String,
      json['description'] as String,
      json['price'] as String,
      json['foodPhoto'] as List<dynamic>,
      json['createAt'] as String,
      json['_id'] as String?,
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'foodPhoto': instance.foodPhoto,
      'createAt': instance.createAt,
    };
