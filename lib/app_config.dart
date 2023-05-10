import 'package:flutter/cupertino.dart';
import 'package:vinyl_social_network/repository/discogs_datasource_interface.dart';
import 'package:vinyl_social_network/service/discogs_data_service_interface.dart';

class AppConfig extends InheritedWidget {
  final DiscogsDataServiceInterface discogsDataService;
  final DiscogsDatasourceInterface discogsDatasource;

  const AppConfig({
    Key? key,
    required Widget child,
    required this.discogsDatasource,
    required this.discogsDataService,
  }) : super(key: key, child: child);

  static AppConfig? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppConfig>();

  @override
  bool updateShouldNotify(_) => false;
}
