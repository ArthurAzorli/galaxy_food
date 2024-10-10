import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../widgets/galaxy_button.dart';

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

  void showMessageDialog(BuildContext context, Function() onClose, {String? title}){
    showDialog(
        context: context,
        builder: (context)
        {
          final theme = Theme.of(context);
          return AlertDialog(

            icon: Icon(
                Icons.warning_amber_rounded, color: theme.colorScheme.secondary,
                size: 65),
            title: Text("Erro ${title??status}!", style: theme.textTheme.titleLarge),
            content: Text(message, style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,),
            actions: [
              Center(
                child: GalaxyButton(
                    style: const ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(200, 50))
                    ),
                    onPressed: onClose,
                    child: const Text("FECHAR")
                ),
              )
            ],
          );
        }
    );
  }
}