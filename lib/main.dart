import 'package:flutter/material.dart';
import 'package:vinyl_social_network/app_config.dart';
import 'package:vinyl_social_network/frontend/views/home_view.dart';
import 'package:vinyl_social_network/repository/discogs_datasource.dart';
import 'package:vinyl_social_network/service/discogs_data_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppConfig(
      discogsDatasource: DiscogsDatasource(),
      discogsDataService: DiscogsDataService(),
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
        initialRoute: HomeView.route,
        routes: {
          HomeView.route: (ctx) =>
              const HomeView(title: "Vinyl Social Network"),
          // LoginScreen.routeName: (ctx) => const LoginScreen(),
          // RegisterScreen.routeName: (ctx) => const RegisterScreen(),
          // QrCodeLoginView.routeName: (ctx) => const QrCodeLoginView(),
          // ProfileScreen.routeName: (ctx) => const ProfileScreen(),
          // PcBuilderScreen.routeName: (ctx) => const PcBuilderScreen(),
          // SelectProductScreen.routeName: (ctx) => const SelectProductScreen(),
          // ProductDetailsScreen.routeName: (ctx) => const ProductDetailsScreen(),
        });
  }
}
