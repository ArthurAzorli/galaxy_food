// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryException _$RepositoryExceptionFromJson(Map<String, dynamic> json) =>
    RepositoryException(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$RepositoryExceptionToJson(
        RepositoryException instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'timestamp': instance.timestamp.toIso8601String(),
    };
