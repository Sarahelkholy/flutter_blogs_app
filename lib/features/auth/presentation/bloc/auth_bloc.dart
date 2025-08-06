// ignore_for_file: depend_on_referenced_packages

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecase/current_user.dart';
import 'package:blog_app/features/auth/domain/usecase/user_login.dart';
import 'package:blog_app/features/auth/domain/usecase/user_sign_up.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLoghin,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userLogin = userLoghin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold((falire) => emit(AuthFailure(falire.message)),
        (user) => emitAuthSuccess(user, emit));
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
          email: event.email, password: event.password, username: event.name),
    );
    res.fold((falire) => emit(AuthFailure(falire.message)),
        (user) => emitAuthSuccess(user, emit));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold((falire) => emit(AuthFailure(falire.message)),
        (user) => emitAuthSuccess(user, emit));
  }

  void emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
