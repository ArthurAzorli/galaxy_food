import 'package:json_annotation/json_annotation.dart';

part 'repository_exception.g.dart';

@JsonSerializable()
class RepositoryException implements Exception{
  final String message;
  final int status;
  final DateTime timestamp;

  RepositoryException({
    required this.status,
    required this.message,
    DateTime? timestamp
  }) : timestamp = timestamp ?? DateTime.now();

  factory RepositoryException.fromJson(Map<String, dynamic> json) => _$RepositoryExceptionFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryExceptionToJson(this);
}