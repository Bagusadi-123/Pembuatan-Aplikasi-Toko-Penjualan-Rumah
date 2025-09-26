// lib/login/view/login_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/bloc/website_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      // Listener untuk menampilkan efek samping seperti Snackbar atau navigasi
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state.status == LoginStatus.succes) {
          // Navigasi ke halaman home atau dashboard
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Login Berhasil!')));
          Navigator.pushReplacementNamed(context, '/home'); //beralih ke beranda
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400, // Atur lebar maksimum form
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _EmailInput(),
                  const SizedBox(height: 16),
                  _PasswordInput(),
                  const SizedBox(height: 32),
                  _LoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Builder hanya untuk membangun ulang widget ini saat state berubah
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity, //membuat input mengambil container

          child: TextField(
            onChanged: (email) {
              // Mengirim event ke BLoC
              context.read<LoginBloc>().add(LoginEmailChanged(email));
            },
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.isPasswordHidden != current.isPasswordHidden,
      builder: (context, state) {
        return SizedBox(
          width: double
              .infinity, // Membuat input mengambil lebar penuh dari container
          child: TextField(
            onChanged: (password) {
              // Mengirim event ke BLoC
              context.read<LoginBloc>().add(LoginPasswordChanged(password));
            },
            obscureText: state.isPasswordHidden,
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  state.isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  context.read<LoginBloc>().add(
                    const LoginTogglePasswordVisibility(),
                  );
                },
              ),
            ),
            // Tambahkan suffix icon untuk toggle visibility
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      // Tidak perlu buildWhen di sini karena kita ingin rebuild setiap status berubah
      builder: (context, state) {
        return state.status == LoginStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  // Mengirim event submit ke BLoC
                  context.read<LoginBloc>().add(const LoginSubmitted());
                },
                child: const Text('LOGIN'),
              );
      },
    );
  }
}
