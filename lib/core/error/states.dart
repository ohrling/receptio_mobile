class State<T> {
  State._();
  factory State.success(T value) = SuccessState<T>;
  factory State.error(T value) = ErrorState<T>;
}

class ErrorState<T> extends State<T> {
  ErrorState(this.msg) : super._();
  final T msg;
}

class SuccessState<T> extends State<T> {
  SuccessState(this.value) : super._();
  final T value;
}

class RecipelistDetailState<T> extends State<T> {
  RecipelistDetailState(this.value) : super._();
  final T value;
}