import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:receptio/injection.dart';

class LoginScreen extends StatelessWidget {
  final authBloc = getIt.get(instanceName: 'AuthBloc');

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/food-background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color(0xffedfdf0).withOpacity(0.4), BlendMode.exclusion),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Text(
              'Join us',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
              ),
            ),
            formBuilder(context),
          ],
        ),
      ),
    );
  }

  Widget formBuilder(context) {
    final focus = FocusNode();
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: usernameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(focus);
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.only(left: 10),
                    filled: true,
                    fillColor: Colors.white70,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green.shade500,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  focusNode: focus,
                  textInputAction: (usernameController.text != null &&
                          usernameController.text.isNotEmpty)
                      ? TextInputAction.done
                      : null,
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.only(left: 10),
                    filled: true,
                    fillColor: Colors.white70,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green.shade500,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: const Text('Sign Up'),
                    color: Colors.green.shade400,
                    textColor: Colors.white,
                    onPressed: () => BlocProvider.of<AuthBloc>(context).add(
                      SignUpEvent(
                          username: usernameController.text,
                          password: passwordController.text),
                    ),
                  ),
                  RaisedButton(
                    autofocus: true,
                    child: const Text('Sign In'),
                    color: Colors.green.shade800,
                    textColor: Colors.white,
                    onPressed: () => BlocProvider.of<AuthBloc>(context).add(
                      LoginEvent(
                          username: usernameController.text,
                          password: passwordController.text),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: const Text('Reset Password'),
                    color: Colors.lightGreen,
                    textColor: Colors.white,
                    onPressed: () => BlocProvider.of<AuthBloc>(context).add(
                      ResetPasswordEvent(
                        username: usernameController.text,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
