import '../network/core_base_reponse.dart';

abstract class RemoteQueryUsecaseInterface<T, P> {
  Future<CoreBaseResponse<T>> call(P params);
}

abstract class RemoteUsecaseInterface<T> {
  Future<CoreBaseResponse<T>> call();
}

abstract class LocalUsecaseInterface<T, P> {
  Future<T> call(P params);
}
