import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'website_event.dart';
part 'website_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    //mendaftarkan handler untuk setiap event
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginTogglePasswordVisibility>(
      _onTogglePasswordVisibility
          as EventHandler<LoginTogglePasswordVisibility, LoginState>,
    );
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    // 1. Emit state 'submitting' untuk menampilkan loading indicator
    emit(state.copyWith(status: LoginStatus.submitting));

    try {
      // Simulasi panggilan API
      await Future<void>.delayed(const Duration(seconds: 2));

      // Simulasi logika validasi
      if (state.email == '' && state.password == '') {
        // 2. Jika berhasil, emit state 'success'
        emit(state.copyWith(status: LoginStatus.succes));
      } else {
        // 3. Jika gagal, emit state 'failure' dengan pesan error
        throw 'Username atau Password salah !';
      }
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void _onTogglePasswordVisibility(
    LoginTogglePasswordVisibility event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }
}
