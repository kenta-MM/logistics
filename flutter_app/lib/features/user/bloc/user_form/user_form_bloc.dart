import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/user/bloc/user_form/user_form_event.dart';
import 'package:logistics/features/user/models/user_model.dart';
import 'package:logistics/features/user/repository/user_repository.dart';
import 'user_form_state.dart';


class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {
  final UserRepository userRepository;
  UserModel? _cachedUser;

  UserFormBloc({required this.userRepository}) : super(UserFormInitial()) {
    on<UserFormLoad>(_onLoad);
    on<UserFormSubmit>(_onSubmit);
  }

  void _onLoad(UserFormLoad event, Emitter<UserFormState> emit) async {
    emit(UserFormLoading());
    try {
        // キャッシュからユーザーデータを取得、もしくは初回のみリポジトリから取得
        final user = _cachedUser ?? event.user;
        _cachedUser = user; // キャッシュに保存

        emit(UserFormLoaded(user: user)); // 初期値を設定
      } catch (e) {
        emit(UserFormSubmissionFailure(error: e.toString()));
      }
  }

  void _onSubmit(UserFormSubmit event, Emitter<UserFormState> emit) async {
    try {
        var isSucceed = false;
        // ユーザー情報をサーバーに送信する処理など
        if (event.user.id == null) {
          isSucceed = await userRepository.addUser(event.user);
        } else {
          isSucceed = await userRepository.updateUser(event.user);
        }

        emit(isSucceed ? UserFormSubmissionSuccess(user: event.user) : UserFormSubmissionFailure(error : 'ユーザーデータの更新に失敗しました。'));
      } catch (e) {
        emit(UserFormSubmissionFailure(error: e.toString()));
      }
  }
}
