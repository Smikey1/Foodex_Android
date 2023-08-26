// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_food_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleFoodResponse _$SingleFoodResponseFromJson(Map<String, dynamic> json) =>
    SingleFoodResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Food.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleFoodResponseToJson(SingleFoodResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
