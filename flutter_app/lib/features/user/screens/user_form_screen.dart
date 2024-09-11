import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/user/bloc/user/user_bloc.dart';
import 'package:logistics/features/user/bloc/user/user_event.dart';
import 'package:logistics/features/user/models/user_model.dart';
import 'package:logistics/features/user/widgets/user_form_view.dart';

class UserFormScreen extends StatelessWidget {
  final UserModel? user;
  final bool isEditMode;

  UserFormScreen({this.user}) : isEditMode = user != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'ユーザー修正' : 'ユーザー登録'),
        actions: isEditMode
            ? [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    if (user != null && user!.id != null) {
                      context.read<UserBloc>().add(DeleteUser(user!.id!));
                      Navigator.pop(context);
                    }
                  },
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: UserFormView(user: user),
      ),
    );
  }
}
