import 'package:equatable/equatable.dart';
import 'package:logistics/features/user/models/role_model.dart';

abstract class RoleState extends Equatable {
  @override
  List<Object> get props => [];
}

class RoleInitial extends RoleState {}

class RoleLoading extends RoleState {}

class RoleLoaded extends RoleState {
  final List<RoleModel> roles;

  RoleLoaded({required this.roles});

  @override
  List<Object> get props => [roles];
}

class RoleLoadFailure extends RoleState {
  final String error;

  RoleLoadFailure({required this.error});

  @override
  List<Object> get props => [error];
}
