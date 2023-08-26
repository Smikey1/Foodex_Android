// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodCategoryResponse _$FoodCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    FoodCategoryResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FoodCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..message = json['message'] as String?;

Map<String, dynamic> _$FoodCategoryResponseToJson(
        FoodCategoryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
