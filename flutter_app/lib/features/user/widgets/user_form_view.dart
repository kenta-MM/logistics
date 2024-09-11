import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/common/components/drop_down_list.dart';
import 'package:logistics/features/user/bloc/role/role_bloc.dart';
import 'package:logistics/features/user/bloc/role/role_event.dart';
import 'package:logistics/features/user/bloc/role/role_state.dart';
import 'package:logistics/features/user/bloc/user_form/user_form_bloc.dart';
import 'package:logistics/features/user/bloc/user_form/user_form_event.dart';
import 'package:logistics/features/user/bloc/user_form/user_form_state.dart';
import 'package:logistics/features/user/models/role_model.dart';
import 'package:logistics/features/user/models/user_model.dart';
import 'package:logistics/features/user/repository/role_repository.dart';
import 'package:logistics/features/user/repository/user_repository.dart';

class UserFormView extends StatefulWidget {
  final UserModel? user;

  UserFormView({this.user});

  @override
  UserFormViewState createState() => UserFormViewState();
}

class UserFormViewState extends State<UserFormView> {
  bool isUserFormLoaded = false; // イベントが一度だけ発行されるように制御
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserFormBloc>(
          create: (context) => UserFormBloc(userRepository: context.read<UserRepository>()),
        ),
        BlocProvider<RoleBloc>(
          create: (context) => RoleBloc(roleRepository: context.read<RoleRepository>())..add(LoadRoles()),
        ),
      ],
      child: BlocBuilder<UserFormBloc, UserFormState>(
        builder: (context, userFormState) {
          if (userFormState is UserFormSubmissionSuccess) {
            // ユーザーの保存が成功したら、画面をポップして戻す
            Future.microtask(() {
                Navigator.pop(context, userFormState.user); 
              });
          }

          return BlocBuilder<RoleBloc, RoleState>(
            builder: (context, roleState) {
              if (roleState is RoleLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (roleState is RoleLoadFailure) {
                return Center(child: Text('エラー: ${roleState.error}'));
              } else if (roleState is RoleLoaded) {
                final roles = roleState.roles;
                // todo:これはいいのか？
                if (!isUserFormLoaded) { 
                  context.read<UserFormBloc>().add(UserFormLoad(user: widget.user, roles: roles));
                  isUserFormLoaded = true;
                }
    
                return _buildForm(context, roles);
              } else {
                return Center(child: Text('権限データがありません'));
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, List<RoleModel> roles) {
    final formKey = GlobalKey<FormState>();

    String userName     = widget.user?.userName ?? "";
    int? supplierId     = widget.user?.supplierId;
    String supplierName = widget.user?.supplierName ?? "";
    String roleName     = widget.user?.roleName ?? "";
    int? roleId         = widget.user?.roleId;

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: userName,
            decoration: InputDecoration(labelText: 'ユーザー名'),
            validator: (value) => value!.isEmpty ? 'ユーザー名を入力してください' : null,
            onSaved: (value) => userName = value!,
          ),
          TextFormField(
            initialValue: supplierName,
            decoration: InputDecoration(labelText: 'サプライヤ名'),
            validator: (value) => value!.isEmpty ? 'サプライヤ名を入力してください' : null,
            onSaved: (value) => supplierName = value!,
          ),
          DropDownList<RoleModel>(
            value : roles.firstWhere((role) => role.id == roleId, orElse: () => roles.first),
            items: roles,
            itemLabelBuilder: (role) => role.name,
            onChanged: (newRole) {
              setState(() {
                  print('Selected Role: ${newRole!.name}, ID: ${newRole.id}');
                  print('roleName: $roleName, roleId: $roleId');  // デバッグ用に出力
                  roleName = newRole!.name;
                  roleId = newRole.id;    
                  print('roleName: $roleName, roleId: $roleId');  // デバッグ用に出力
  
              });
            },
            validator: (newRole) {
              return (newRole == null || newRole.name.isEmpty) ? '権限を設定してください' : null;
            },
          ),
          // DropdownButtonFormField<String>(
          //   value: roles.firstWhere((role) => role.id == roleId, orElse: () => roles.first).name,
          //   items: roles
          //       .map((role) => DropdownMenuItem(
          //             value: role.name,
          //             child: Text(role.name),
          //           ))
          //       .toList(),
          //   onChanged: (value) {
          //     final selectedRole = roles.firstWhere((role) => role.name == value);
          //     roleName = selectedRole.name;
          //     roleId = selectedRole.id;
          //   },
          //   decoration: InputDecoration(labelText: '権限'),
          //   validator: (value) => value!.isEmpty ? '権限を設定してください' : null,
          // ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                context.read<UserFormBloc>().add(UserFormSubmit(
                  user: UserModel(
                    id: widget.user?.id,
                    userName: userName,
                    roleId: roleId!,
                    roleName: roleName,
                    supplierName: supplierName,
                    supplierId: supplierId,
                  ),
                ));
              }
            },
            child: Text(widget.user?.id == null ? '登録' : '更新'),
          ),
        ],
      ),
    );
  }
}
