// lib/models/user.dart

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int?    id;
  final String  userName;
  final int?    supplierId;
  final String? supplierName;
  final int     roleId;
  final String  roleName;


  UserModel({
    this.id,
    required this.userName,
    this.supplierId,
    this.supplierName,
    required this.roleId,
    required this.roleName,
  });

 factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['name'],
      supplierId: json['supplier_id'] ?? -1,
      supplierName: json['supplier_name'] ?? '',
      roleId: json['role_id'] ?? -1,
      roleName: json['role_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': userName,
      'supplier_id': supplierId,
      'supplier_name': supplierName,
      'role_id': roleId,
      'role_name': roleName,
    };
  }
  @override
  List<Object?> get props => [id, userName, supplierName, roleName];
}
