import 'package:equatable/equatable.dart';

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

abstract class UseCase<T, Params> {
  Future<Result<T>> call(Params params);
}


class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
