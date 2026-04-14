class CoreBaseResponse<Data> {
  CoreBaseResponse({this.data, this.isError = false});

  final Data? data;
  final bool isError;
}
