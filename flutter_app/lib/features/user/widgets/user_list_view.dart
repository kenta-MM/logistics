import 'package:flutter/material.dart';
import 'package:logistics/features/user/models/user_model.dart';

class UserListView extends StatelessWidget {
  final List<UserModel> users;

  UserListView({required this.users});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ヘッダー
        Container(
          color: Colors.grey[300], // ヘッダーの背景色
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: const [
              Expanded(child: Text('ユーザー名', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('サプライヤ名', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('権限', style: TextStyle(fontWeight: FontWeight.bold))),
              SizedBox(width: 50), // 編集ボタン用のスペース
            ],
          ),
        ),
        // ユーザー一覧
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: Text(user.userName)),
                    Expanded(child: Text(user.supplierName ?? "")),
                    Expanded(child: Text(user.roleName)),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // 編集処理
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
