abstract class ResponseInterface {
  late final String message;
  late final bool success;

  ResponseInterface({required this.message, required this.success});
}
