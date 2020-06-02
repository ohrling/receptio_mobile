import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/welcome_screen.dart';

import 'core/routes/route_generator.dart';
import 'features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'injection.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  configureInjection();
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) {
        return getIt.get(instanceName: 'AuthBloc')
          ..add(
            WelcomeEvent(),
          );
      },
      child: MaterialApp(
        title: 'Receptio',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffedfdf0), // Hex-color: #edfdf0
          primaryColor: Colors.green.shade500,
          accentColor: Colors.green.shade400,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        home: Receptio(),
      ),
    ),
  );
}

class Receptio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            Navigator.popAndPushNamed(context, '/');
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          } else if (state is SignedUp) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message + ' Please sign in.'),
              ),
            );
            Navigator.pop(context);
          } else if (state is PasswordResetted) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.pop(context);
          } else if (state is LoggedIn) {
            Navigator.popAndPushNamed(
              context,
              '/userScreen',
              arguments: context.bloc<AuthBloc>(),
            );
          } else if (state is DisplayLogin) {
            Navigator.pushNamed(context, '/login');
          } else if (state is AuthLoading) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Welcome) {
              return WelcomeScreen();
            } else if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return WelcomeScreen();
          },
        ),
      ),
    );
  }
}
