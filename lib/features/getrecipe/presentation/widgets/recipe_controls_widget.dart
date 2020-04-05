import 'package:flutter/material.dart';

class RecipeControlsWidget extends StatelessWidget {
  const RecipeControlsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // TextField
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.sentiment_very_dissatisfied),
            Icon(Icons.sentiment_dissatisfied),
            Icon(Icons.sentiment_neutral),
            Icon(Icons.sentiment_satisfied),
            Icon(Icons.sentiment_very_satisfied),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                color: Colors.yellow.shade700,
                textColor: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.edit,
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Edit Recipe',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: RaisedButton(
                color: Colors.green.shade400,
                textColor: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.save,
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Save Recipe',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
