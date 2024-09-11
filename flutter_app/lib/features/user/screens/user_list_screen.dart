import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/user/bloc/user/user_bloc.dart';
import 'package:logistics/features/user/bloc/user/user_event.dart';
import 'package:logistics/features/user/bloc/user/user_state.dart';
import 'package:logistics/features/user/widgets/search_filter_section.dart';
import 'package:logistics/features/user/widgets/user_list_paging_view.dart'; // UserListPagingView をインポート
import 'user_form_screen.dart';

class UserListScreen extends StatefulWidget {
  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();

    // スクロールが一番下に達したら次のページをロード
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoadingMore) {
        _onLoadMore();
      }
    });
  }

  Future<void> _loadUsers({String? searchQuery}) async {
    context.read<UserBloc>().add(LoadUsers(
      searchQuery: searchQuery,
      page: _currentPage,
      pageSize: 10, // ページあたりのユーザー数
    ));
  }

  void _onSearch() {
    setState(() {
      _currentPage = 1; // 検索時にページ番号をリセット
      _loadUsers(searchQuery: _searchController.text);
    });
  }

  void _onLoadMore() {
    final state = context.read<UserBloc>().state;
    if (state is UserLoaded && state.hasMore && !_isLoadingMore) {
      setState(() {
        _currentPage++; // 次のページ番号
        _isLoadingMore = true;
      });
      _loadUsers(searchQuery: _searchController.text).then((_) {
        setState(() {
          _isLoadingMore = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー一覧'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserFormScreen(user: null),
                ),
              );
              if (mounted && result != null) {
                context.read<UserBloc>().add(AddUser(result));
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchFilterSection(
            searchController: _searchController,
            onSearch: _onSearch,
          ),
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading && _currentPage == 1) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UserLoaded) {
                  return UserListPagingView(
                    users: state.users,
                    hasMore: state.hasMore,
                    onLoadMore: _onLoadMore, // 次のページをロードするコールバック
                    scrollController: _scrollController, // スクロールコントローラを渡す
                  );
                } else if (state is UserOperationFailure) {
                  return Center(child: Text('エラー: ${state.error}'));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
