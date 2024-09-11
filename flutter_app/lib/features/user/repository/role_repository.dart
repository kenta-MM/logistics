// lib/repository/user_repository.dart

import 'dart:convert';
import 'package:logistics/features/user/models/role_model.dart';
import '../../common/repositories/api_repository.dart';

class RoleRepository {
  final ApiRepository apiRepository;
  static const String accessApiEndPoinnName = 'roles';

  RoleRepository({required this.apiRepository});

  Future<List<RoleModel>> getRoles() async {
    var rolesJsonString = await apiRepository.fetchData(accessApiEndPoinnName);

    if (rolesJsonString.isEmpty) {
      return List<RoleModel>.empty();
    }

    // JSON文字列をデコードし、List<dynamic>に変換
    var rolesJsonList = jsonDecode(rolesJsonString) as List;
    // 各要素をUserModelに変換
    List<RoleModel> roleList = rolesJsonList.map((roleJson) {
      return RoleModel.fromJson(roleJson);
    }).toList();
    
    return roleList;
  }
}
