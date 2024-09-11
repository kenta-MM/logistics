// lib/bloc/user_event.dart

import 'package:equatable/equatable.dart';
import 'package:logistics/features/user/models/user_model.dart';

abstract class UserEvent extends Equatable {
  final int page;
  final int pageSize;

  UserEvent({this.page = 1, this.pageSize = 10});

  @override
  List<Object?> get props => [page, pageSize];
}

class LoadUsers extends UserEvent {
  final String? searchQuery;

  LoadUsers({this.searchQuery, super.page, super.pageSize});

  @override
  List<Object?> get props => [page, pageSize];
}

class AddUser extends UserEvent {
  final UserModel user;

  AddUser(this.user, {super.page, super.pageSize});

  @override
  List<Object?> get props => [user, page, pageSize];
}

class UpdateUser extends UserEvent {
  final UserModel user;

  UpdateUser(this.user, {super.page, super.pageSize});

  @override
  List<Object?> get props => [user, page, pageSize];
}

class DeleteUser extends UserEvent {
  final int userId;

  DeleteUser(this.userId, {super.page, super.pageSize});

  @override
  List<Object?> get props => [userId, super.page, super.pageSize];
}
