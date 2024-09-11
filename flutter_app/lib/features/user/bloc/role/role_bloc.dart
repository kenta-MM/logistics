import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/user/repository/role_repository.dart';
import 'role_event.dart';
import 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final RoleRepository roleRepository;

  RoleBloc({
    required this.roleRepository,
  }) : super(RoleInitial()) {
    // イベントごとのハンドラを登録
    on<LoadRoles>((event, emit) async {
      emit(RoleLoading());
      try {
        // データの取得
        final roles = await roleRepository.getRoles();
        emit(RoleLoaded(roles: roles)); // ロード完了
      } catch (e) {
        emit(RoleLoadFailure(error: e.toString()));
      }
    });
  }
}
