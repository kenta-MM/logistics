// lib/features/user/bloc/role_event.dart

import 'package:equatable/equatable.dart';

abstract class RoleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRoles extends RoleEvent {}
