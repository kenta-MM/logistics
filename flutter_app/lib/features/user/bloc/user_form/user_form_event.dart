import 'package:equatable/equatable.dart';
import 'package:logistics/features/user/models/role_model.dart';
import 'package:logistics/features/user/models/user_model.dart';

abstract class UserFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserFormLoad extends UserFormEvent {
  final UserModel? user;
  final List<RoleModel> roles;

  UserFormLoad({this.user,required this.roles});

  @override
  List<Object?> get props => [user, roles];
}

class UserFormSubmit extends UserFormEvent {
  final UserModel user;

  UserFormSubmit({required this.user});

  @override
  List<Object> get props => [user];
}

class UserFormDelete extends UserFormEvent {
  final int userId;

  UserFormDelete(this.userId);

  @override
  List<Object?> get props => [userId];
}
