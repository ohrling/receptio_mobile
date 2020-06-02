import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptio/core/util/ui_snippets.dart';
import 'package:receptio/features/api/presentation/bloc/receptio/bloc.dart';
import 'package:receptio/features/api/presentation/widgets/message_display.dart';
import 'package:receptio/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:receptio/injection.dart';

class UserScreen extends StatefulWidget {
  final AuthBloc authBloc;

  const UserScreen({Key key, @required this.authBloc}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReceptioBloc>(
      create: (context) {
        return getIt.get(instanceName: 'ReceptioBloc');
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xffedfdf0),
              image: DecorationImage(
                image: AssetImage('images/food-background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Color(0xffedfdf0).withOpacity(0.4), BlendMode.exclusion),
              ),
            ),
            child: BlocListener<ReceptioBloc, ReceptioState>(
              listener: (BuildContext context, ReceptioState state) {
                if (state is UserError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                    ),
                  );
                }
              },
              child: BlocBuilder<ReceptioBloc, ReceptioState>(
                builder: (BuildContext context, ReceptioState state) {
                  if (state is ReceptioInitial) {
                    context.bloc<ReceptioBloc>()
                      ..add(
                        LoadUserRecipes(widget.authBloc.accessToken),
                      );
                  } else if (state is UserRecipesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is UserRecipesLoaded) {
                    return Container(
                      margin: EdgeInsets.all(10.0 * scaleForDevice(context)),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 70.0 * scaleForDevice(context)),
                              child: Text(
                                'Nice to see you ${widget.authBloc.user.nickname}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.0 * scaleForDevice(context),
                                ),
                              ),
                            ),
                            Divider(
                              indent: 20.0,
                              endIndent: 20.0,
                              height: 30 * scaleForDevice(context),
                            ),
                            Text(
                              'What do you want to do today:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                fontSize: 20.0 * scaleForDevice(context),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.all(
                                    60.0 * scaleForDevice(context)),
                                child: Wrap(
                                  children: [
                                    buttons(context),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: 200 * scaleForDevice(context),
                                child: userRecipes(
                                  context.bloc<ReceptioBloc>(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return MessageDisplay(
                    message:
                        'Something went wrong displaying your information.',
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget userRecipes(ReceptioBloc bloc) {
    return ListView.builder(
      itemCount: bloc.userRecipes.getRecipes.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/recipeDetail',
              arguments: bloc.userRecipes.getRecipes[index]),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(40.0 * scaleForDevice(context)),
            ),
            elevation: 18.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.green.shade300,
              ),
              width: 160.0 * scaleForDevice(context),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20 * scaleForDevice(context),
                    60 * scaleForDevice(context),
                    20 * scaleForDevice(context),
                    0),
                child: Wrap(
                  children: [
                    Text(
                      bloc.userRecipes.getRecipes[index].name,
                      style: TextStyle(
                          fontSize: 25 * scaleForDevice(context),
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buttons(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.9,
            child: RaisedButton(
              onPressed: () => {
                Navigator.pushNamed(context, '/recipeSearch',
                    arguments: widget.authBloc.accessToken),
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 15 * scaleForDevice(context),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Search for recipe',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15 * scaleForDevice(context)),
                  ),
                ],
              ),
              color: Colors.green.shade400,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.9,
            child: RaisedButton(
              onPressed: () => {
                Navigator.pushNamed(context, '/addRecipe',
                    arguments: widget.authBloc.accessToken),
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15 * scaleForDevice(context),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Add recipe',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15 * scaleForDevice(context)),
                  ),
                ],
              ),
              color: Colors.green.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
