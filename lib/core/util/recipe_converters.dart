import 'package:injectable/injectable.dart';
import 'package:receptio_mobile/core/error/states.dart';

@injectable
class InputConverter {
  State stringToInteger(String str) {
    try {
      final id = int.parse(str);
      if (id < 1) {
        return State<String>.error('Värdet måste vara positivt');
      } else {
        return State<int>.success(id);
      }
    } on Exception {
      return State<String>.error('Det var en ej en integer som inmatning.');
    }
  }
  
  State listToString(List<String> searchValues) {
    if(searchValues != null){
      String str = searchValues.toString();
      String search = str.toLowerCase();
      search = search
          .split(RegExp('(?<=[a-z])\\s'))
          .join('%20')
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(' ', '');
      return State<String>.success(search);
    }
    return State<String>.error('Något var fel med dessa sökvärden');
  }
}
