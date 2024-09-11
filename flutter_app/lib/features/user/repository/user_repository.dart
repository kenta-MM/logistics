// lib/repository/user_repository.dart

import 'dart:convert';

import '../../common/repositories/api_repository.dart';
import '../models/user_model.dart';

class UserRepository {
  final ApiRepository apiRepository;
  static const String accessApiEndPoinnName = 'users';

  UserRepository({required this.apiRepository});

  Future<List<UserModel>> getUsers(int page, int pageSize) async {
    var usersJsonString = await apiRepository.fetchData(accessApiEndPoinnName, params: 'page=$page, pageSize=$pageSize');

    if (usersJsonString.isEmpty) {
      return List<UserModel>.empty();
    }

    // JSON文字列をデコードし、List<dynamic>に変換
    var usersJsonList = jsonDecode(usersJsonString) as List;
    // 各要素をUserModelに変換
    List<UserModel> userList = usersJsonList.map((userJson) {
      return UserModel.fromJson(userJson);
    }).toList();
    
    return userList;
  }

  Future<bool> addUser(UserModel addUser) async {
    var postJson = addUser.toJson();
    postJson.remove('id');

    var res = await apiRepository.postData(accessApiEndPoinnName, postJson);

    return jsonDecode(res)['is_success'] as bool;
  }

  Future<bool> updateUser(UserModel updatedUser) async{
    var postJson = updatedUser.toJson();
    var res = await apiRepository.postData(accessApiEndPoinnName, postJson);
    return jsonDecode(res)['is_succees'] as bool;
  }

  Future<void> deleteUser(int userId) async {
    // TODO:削除処理
    // _users.removeWhere((user) => user.id == userId);
  }
}
