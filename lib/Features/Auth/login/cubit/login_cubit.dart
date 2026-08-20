import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Core/utils/shared_preference_utils.dart';
import 'package:employee_application/Features/Auth/login/Data/Model/login_entity.dart';
import 'package:employee_application/Features/Auth/login/Data/Repostry/basereposotry_login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._baseReposotryLogin, this._sharedPreferencesUtils)
    : super(const LoginState.initial());

  final BaseReposotryLogin _baseReposotryLogin;
  final SharedPreferencesUtils _sharedPreferencesUtils;

  Future<void> emitLogin(String login, String password) async {
    emit(const LoginState.loading());
    final deviceToken = await FirebaseMessaging.instance.getToken();
    final response = await _baseReposotryLogin.login(
      login,
      password,
      deviceToken ?? "",
    );

    response.fold((l) => emit(LoginState.error(l)), (r) {
      _sharedPreferencesUtils.setToken(r.token);
      _sharedPreferencesUtils.setUserName(r.nameUser);
      _sharedPreferencesUtils.setImageUrl(r.imageUserUrl);
      _sharedPreferencesUtils.setGovernmentEntity(r.governmentEntityUser);
      emit(LoginState.success(r));
    });
  }
}
