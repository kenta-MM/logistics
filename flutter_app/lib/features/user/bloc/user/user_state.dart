// lib/bloc/user_state.dart

import 'package:equatable/equatable.dart';
import 'package:logistics/features/user/models/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> users;
  final bool hasMore; // さらにページがあるかどうかを示す
  final int currentPage;

  UserLoaded({
    required this.users,
    required this.hasMore,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [users];
}

class UserOperationFailure extends UserState {
  final String error;

  UserOperationFailure(this.error);

  @override
  List<Object?> get props => [error];
}
