import 'failure.dart';

sealed class Result<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) error,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else {
      return error((this as Error<T>).failure);
    }
  }
}

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
