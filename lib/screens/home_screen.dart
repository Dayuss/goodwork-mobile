import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodwork/blocs/auth/auth_state.dart';
import 'package:goodwork/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goodwork/blocs/auth/auth_bloc.dart';
import 'package:goodwork/blocs/auth/auth_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({this.authUser}) : super();

  final User authUser;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthState state;
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Good Work',
      home: Scaffold(
        appBar: AppBar(title: const Text('Good Work')),
        body: Row(
            children: <Widget>[
              Container(
                child: Text('Welcome ${widget.authUser.name}'),
              ),
              RaisedButton(
                onPressed: () {final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);authBloc.dispatch(LoggedOut());},
                child: Text('Disabled Button', style: TextStyle(fontSize: 20)),
              ),
            ],
          )
      ),
    );
  }
}
