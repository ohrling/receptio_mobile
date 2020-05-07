import 'dart:async';

// TODO: Implement this on the searchinput
class InputValidators {
  final validateSearchString = StreamTransformer<String, String>.fromHandlers(
      handleData: (searchString, sink) {
    if (searchString.length > 3) {
      sink.add(searchString);
    } else {
      sink.addError('Too short value');
    }
  });
}