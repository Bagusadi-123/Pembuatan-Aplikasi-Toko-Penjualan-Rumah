part of 'website_bloc.dart';

//kelas dasar untuk semua event login
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

//Event ketika user mengetik di field password
class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

//Event ketika user menekan tombol login
class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class LoginTogglePasswordVisibility extends LoginEvent {
  const LoginTogglePasswordVisibility();
}
