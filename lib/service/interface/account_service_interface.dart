abstract class AccountServiceInterface {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> removeToken();

  Future<String?> getDiscogsUsername();
  Future<void> setDiscogsUsername(String discogsUsername);
  Future<void> removeDiscogsUsername();
}
