import 'package:flutter/material.dart';
import 'package:logistics/features/user/models/user_model.dart';
import 'user_list_view.dart';

class UserListPagingView extends StatelessWidget {
  final List<UserModel> users;
  final bool hasMore;
  final VoidCallback onLoadMore;
  final ScrollController scrollController;

  UserListPagingView({
    required this.users,
    required this.hasMore,
    required this.onLoadMore,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        // スクロールが一番下に達したら次のページをロード
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && hasMore) {
          onLoadMore();
        }
        return false;
      },
      child: Column(
        children: [
          Expanded(
            child: UserListView(users: users), // ユーザーリストを表示
          ),
          if (hasMore) // 次のページが存在する場合、ローディングインジケータを表示
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
