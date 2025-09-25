part of 'website_bloc.dart';

@immutable
sealed class WebsiteState {
  get email => null;
}

final class WebsiteInitial extends WebsiteState {}

//enum untuk status form
enum LoginStatus { initial, submitting, succes, failure }

final class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.email = '',
    this.password = '',
    this.errorMessage = '',
    this.isPasswordHidden = true,
  });

  final LoginStatus status;
  final String email;
  final String password;
  final String errorMessage;
  final bool isPasswordHidden;

  //Method copyWith untuk membuat state baru berrdasarkan state lama
  LoginState copyWith({
    LoginStatus? status,
    String? email,
    String? password,
    String? errorMessage,
    bool? isPasswordHidden,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
    );
  }

  @override
  List<Object> get props => [
    status,
    email,
    password,
    errorMessage,
    isPasswordHidden,
  ];
}
