import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/core/util/ui_snippets.dart';
import 'package:receptio/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Welcome(bloc: context.bloc<AuthBloc>());
  }
}

class _Welcome extends StatelessWidget {
  final AuthBloc bloc;

  const _Welcome({Key key, @required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/food-background.jpg'),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(Color(0xffedfdf0), BlendMode.colorBurn),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 40.0 * scaleForDevice(context),
                ),
              ),
              Text(
                'Receptio',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80.0 * scaleForDevice(context),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                elevation: 10,
                onPressed: () async {
                  bloc.add(DisplayLoginEvent());
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Join the pack of chefs',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25 * scaleForDevice(context)),
                  ),
                ),
                color: Colors.green.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
