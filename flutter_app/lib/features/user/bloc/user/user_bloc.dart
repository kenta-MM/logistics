import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<AddUser>(_onAddUser);
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
  }

  void _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    if (state is UserLoaded) {
      // 既にデータがロードされている場合、再取得しない
      return;
    }

    emit(UserLoading());
    try {
      final users = await userRepository.getUsers(event.page, event.pageSize);
      final hasMore = users.length == event.pageSize;
      emit(UserLoaded(users: users, hasMore: hasMore, currentPage: event.page));
    } catch (e) {
      emit(UserOperationFailure(e.toString()));
    }
  }

  void _onAddUser(AddUser event, Emitter<UserState> emit) async {
    try {
      await userRepository.addUser(event.user);
      final users = await userRepository.getUsers(event.page, event.pageSize);
      final hasMore = users.length == event.pageSize;
      emit(UserLoaded(users: users, hasMore: hasMore, currentPage: event.page));
    } catch (e) {
      emit(UserOperationFailure(e.toString()));
    }
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    try {
      await userRepository.updateUser(event.user);
      final users = await userRepository.getUsers(event.page, event.pageSize);
      final hasMore = users.length == event.pageSize;
      emit(UserLoaded(users: users, hasMore: hasMore, currentPage: event.page));
    } catch (e) {
      emit(UserOperationFailure(e.toString()));
    }
  }

  void _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    try {
      await userRepository.deleteUser(event.userId);
      final users = await userRepository.getUsers(event.page, event.pageSize);
      final hasMore = users.length == event.pageSize;
      emit(UserLoaded(users: users, hasMore: hasMore, currentPage: event.page));
    } catch (e) {
      emit(UserOperationFailure(e.toString()));
    }
  }
}
