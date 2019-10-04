import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodwork/blocs/auth/auth_bloc.dart';
import 'package:goodwork/blocs/auth/auth_state.dart';
import 'package:goodwork/models/user.dart';
import 'package:goodwork/screens/home_screen.dart';
import 'package:goodwork/screens/login_screen.dart';
import 'package:goodwork/widgets/side_menu.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.teal,
  ));
  runApp(GoodworkApp());
}

class GoodworkApp extends StatelessWidget {
  final AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goodwork',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider.value(
        value: authBloc,
        child: BlocBuilder(
          bloc: authBloc,
          builder: (BuildContext context, AuthState state) {
            if (state is UserLoaded) {
              return Scaffold(
                extendBody: true,
                backgroundColor: Colors.grey[200],
                drawer: showDrawerMenu(state.authUser),
                body: loadScreen(state),
              );
            }
            return Scaffold(
              extendBody: true,
              backgroundColor: Colors.grey[200],
              body: loadScreen(state),
            );
          },
        ),
      ),
    );
  }

  Widget loadScreen(AuthState state) {
    if (state is InitialAuthState) {
      return loadLoginScreen();
    } else if (state is UserLoading) {
      return showLoadingScreen();
    } else if (state is UserLoaded) {
      return showHomeScreen(state.authUser);
    } else if (state is UserNotFound) {
      return loadLoginScreen();
    }
  }

  void dispose() {
    authBloc.dispose();
  }
}

Widget loadLoginScreen() {
  return Center(
    child: LoginScreen(),
  );
}

Widget showHomeScreen(User authUser) {
  return Center(
    child: HomeScreen(
      authUser: authUser,
    ),
  );
}

Widget showLoadingScreen() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
    ),
  );
}

Widget showDrawerMenu(User authUser) {
  return SideMenu(
    authUser: authUser,
  );
}
