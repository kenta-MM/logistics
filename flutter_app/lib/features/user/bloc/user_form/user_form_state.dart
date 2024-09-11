import 'package:equatable/equatable.dart';
import 'package:logistics/features/user/models/user_model.dart';

abstract class UserFormState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserFormInitial extends UserFormState {}

class UserFormLoading extends UserFormState {}

class UserFormLoaded extends UserFormState {
  final UserModel? user;

  UserFormLoaded({this.user});

  @override
  List<Object?> get props => [user];
}

class UserFormSubmissionSuccess extends UserFormState {
  final UserModel? user;

  UserFormSubmissionSuccess({this.user});

  @override
  List<Object?> get props => [user];
}

class UserFormSubmissionFailure extends UserFormState {
  final String error;

  UserFormSubmissionFailure({required this.error});

  @override
  List<Object> get props => [error];
}
