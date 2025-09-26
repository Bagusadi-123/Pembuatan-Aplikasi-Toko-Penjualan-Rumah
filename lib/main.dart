import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/bloc/website_bloc.dart';
import 'package:my_project/bloc/login_page.dart';
import 'package:my_project/pages/home_page.dart';
import 'package:my_project/pages/profile_page.dart';
import 'package:my_project/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        // Tambahkan BLoC lain jika diperlukan
        // BlocProvider(
        //   create: (context) => OtherBloc(),
        // ),
      ],
      child: MaterialApp(
        title: 'Toko Penjualan Rumah Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/splash',
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/splash': (context) => const SplashScreen(),
          '/profile': (context) => const ProfilePage(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => const SplashScreen());
        },
      ),
    );
  }
}
