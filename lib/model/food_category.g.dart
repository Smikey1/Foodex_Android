// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodCategory _$FoodCategoryFromJson(Map<String, dynamic> json) => FoodCategory(
      json['foodCategoryTitle'] as String,
      json['foodCategoryImageUrl'] as String,
      json['foodCategoryCreateAt'] as String,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$FoodCategoryToJson(FoodCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'foodCategoryTitle': instance.foodCategoryTitle,
      'foodCategoryImageUrl': instance.foodCategoryImageUrl,
      'foodCategoryCreateAt': instance.foodCategoryCreateAt,
    };
