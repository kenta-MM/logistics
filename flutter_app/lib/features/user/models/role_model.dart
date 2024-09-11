// lib/models/user.dart

import 'package:equatable/equatable.dart';

class RoleModel extends Equatable {
  final int     id;
  final String  name;

  RoleModel({
    required this.id,
    required this.name,
  });

 factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object> get props => [id, name];
}