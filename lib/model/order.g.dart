// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String?,
      userId: json['userId'] == null
          ? null
          : User.fromJson(json['userId'] as Map<String, dynamic>),
      foodId: json['foodId'] == null
          ? null
          : Food.fromJson(json['foodId'] as Map<String, dynamic>),
      orderedQuantity: json['orderedQuantity'] as int?,
      totalPrice: json['totalPrice'] as int?,
      deliveryStatusMessage: json['deliveryStatusMessage'] as String?,
      deliveryDate: json['deliveryDate'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'foodId': instance.foodId,
      'orderedQuantity': instance.orderedQuantity,
      'totalPrice': instance.totalPrice,
      'deliveryStatusMessage': instance.deliveryStatusMessage,
      'deliveryDate': instance.deliveryDate,
    };
