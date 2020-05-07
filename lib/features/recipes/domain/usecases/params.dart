import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NullParam extends Equatable {}

class SearchParam extends Equatable {
  final String searchString;

  SearchParam({@required this.searchString}) : super([searchString]);
}

class PostParam extends Equatable {
  final Map parameters;

  PostParam({@required this.parameters}) : super([parameters]);
}
