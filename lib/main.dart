import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/collection_view_model.dart';
import 'package:vinyl_social_network/frontend/views/collection_view.dart';
import 'package:vinyl_social_network/frontend/views/login_view.dart';
import 'package:vinyl_social_network/frontend/views/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CollectionViewModel()),
        ],
        child: MaterialApp(
            title: 'Vinyl Social Network',
            theme: ThemeData(
              brightness: Brightness.light,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(brightness: Brightness.dark),
            themeMode: ThemeMode.light,
            initialRoute: CollectionView.route,
            routes: {
              CollectionView.route: (ctx) => const CollectionView(),
              LoginView.route: (ctx) => const LoginView(),
              RegisterView.route: (ctx) => const RegisterView(),
              // QrCodeLoginView.routeName: (ctx) => const QrCodeLoginView(),
              // ProfileScreen.routeName: (ctx) => const ProfileScreen(),
              // PcBuilderScreen.routeName: (ctx) => const PcBuilderScreen(),
              // SelectProductScreen.routeName: (ctx) => const SelectProductScreen(),
              // ProductDetailsScreen.routeName: (ctx) => const ProductDetailsScreen(),
            }));
  }
}
