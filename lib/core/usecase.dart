import 'failure.dart';

sealed class Result<T> {}

class Success<T> extends Result<T> {
  final T data;
  Success(this.data);
}

class Error<T> extends Result<T> {
  final Failure failure;
  Error(this.failure);
}

abstract class UseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}


class NoParams {}
