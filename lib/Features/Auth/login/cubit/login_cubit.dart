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
    final response = await _baseReposotryLogin.login(
      login,
      password,
      fetchDeviceToken().toString(),
    );

    response.fold((l) => emit(LoginState.error(l)), (r) {
      _sharedPreferencesUtils.setToken(r.token);
      emit(LoginState.success(r));
    });
  }

  Future<String?> fetchDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  Future<void> fakEmitLogin(String login, String password) async {
    emit(const LoginState.loading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(
      LoginState.success(
        LoginEntity(
          message: "Fake success",
          token: '11111111111111111111111111111111111',
          nameUser: "محمد سعيد",
          imageUserUrl:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIb1Rzl1hRfAv4mVFgDajXGAByt2Jhq8ECIQ&s",
          governmentEntityUser: "شعبة الأحوال المدنية",
        ),
      ),
    );
    return;
  }
}
