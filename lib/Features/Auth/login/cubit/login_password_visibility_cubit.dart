import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class LoginPasswordVisibilityCubit extends Cubit<bool> {
  LoginPasswordVisibilityCubit() : super(true);

  void toggle() => emit(!state);
}