import 'package:flutter/material.dart';
import 'package:vinyl_social_network/api/auth_service.dart';
import 'package:vinyl_social_network/app_config.dart';
import 'package:vinyl_social_network/frontend/views/home_view.dart';
import 'package:vinyl_social_network/frontend/views/login_view.dart';
import 'package:vinyl_social_network/frontend/views/register_view.dart';
import 'package:vinyl_social_network/repository/album_local_repository.dart';
import 'package:vinyl_social_network/repository/discogs_datasource.dart';
import 'package:vinyl_social_network/service/discogs_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(AppConfig(
      discogsDatasource: DiscogsDatasource(),
      discogsDataService: DiscogsDataService(),
      albumLocalRepository: AlbumLocalRepository(),
      authService: AuthService(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vinyl Social Network',
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.light,
        initialRoute: RegisterView.route,
        routes: {
          HomeView.route: (ctx) =>
              const HomeView(title: "Vinyl Social Network"),
          LoginView.route: (ctx) => const LoginView(),
          RegisterView.route: (ctx) => const RegisterView(),
          // QrCodeLoginView.routeName: (ctx) => const QrCodeLoginView(),
          // ProfileScreen.routeName: (ctx) => const ProfileScreen(),
          // PcBuilderScreen.routeName: (ctx) => const PcBuilderScreen(),
          // SelectProductScreen.routeName: (ctx) => const SelectProductScreen(),
          // ProductDetailsScreen.routeName: (ctx) => const ProductDetailsScreen(),
        });
  }
}
