import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Text(
                  'Welcome to',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green.shade200,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Text(
                'Receptio',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green.shade400,
                  fontSize: 50.0,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () => {
                  Navigator.pushNamed(context, '/recipeSearch'),
                },
                child: Text(
                  'Search for recipe',
                  style: TextStyle(color: Colors.white70),
                ),
                color: Colors.green.shade400,
              ),
              RaisedButton(
                onPressed: () => {
                  Navigator.pushNamed(context, '/addRecipe'),
                },
                child: Text(
                  'Add recipe',
                  style: TextStyle(color: Colors.white70),
                ),
                color: Colors.green.shade400,
              )
            ],
          ),
        ),
      ),
    );
  }
}