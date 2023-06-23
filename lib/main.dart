import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/chats_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/collection_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/post_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/stylus_view_model.dart';
import 'package:vinyl_social_network/frontend/views/album_details_view.dart';
import 'package:vinyl_social_network/frontend/views/chat_view.dart';
import 'package:vinyl_social_network/frontend/views/home_view.dart';
import 'package:vinyl_social_network/frontend/views/login_view.dart';
import 'package:vinyl_social_network/frontend/views/people_view.dart';
import 'package:vinyl_social_network/frontend/views/post_details_view.dart';
import 'package:vinyl_social_network/frontend/views/register_view.dart';
import 'package:vinyl_social_network/frontend/views/user_details_view.dart';
import 'package:vinyl_social_network/service/background_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.notification.isDenied.then((value) => {
        if (value) {Permission.notification.request()}
      });

  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: "key1",
        channelName: "Vinyl Social Network Messages",
        channelDescription: "Vinyl Social Network Messages",
        playSound: true)
  ]);

  await initializeService();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CollectionViewModel()),
          ChangeNotifierProvider(create: (_) => ProfileViewModel()),
          ChangeNotifierProvider(create: (_) => StylusViewModel()),
          ChangeNotifierProvider(create: (_) => PostViewModel()),
          ChangeNotifierProvider(create: (_) => ChatsViewModel()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Vinyl Social Network',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFF363f93)),
              useMaterial3: true,
            ),
            initialRoute: HomeView.route,
            routes: {
              HomeView.route: (ctx) => const HomeView(),
              LoginView.route: (ctx) => const LoginView(),
              RegisterView.route: (ctx) => const RegisterView(),
              AlbumDetailsView.route: (ctx) => const AlbumDetailsView(),
              PostDetailsView.route: (ctx) => const PostDetailsView(),
              UserDetailsView.route: (ctx) => const UserDetailsView(),
              PeopleView.route: (ctx) => const PeopleView(),
              ChatView.route: (ctx) => const ChatView(),
            }));
  }
}
