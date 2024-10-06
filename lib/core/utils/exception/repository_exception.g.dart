// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryException _$RepositoryExceptionFromJson(Map<String, dynamic> json) =>
    RepositoryException(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$RepositoryExceptionToJson(
        RepositoryException instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'timestamp': instance.timestamp.toIso8601String(),
    };
