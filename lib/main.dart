import 'package:flutter/material.dart';
import 'package:vinyl_social_network/app_config.dart';
import 'package:vinyl_social_network/models/album.dart';
import 'package:vinyl_social_network/repository/discogs_datasource.dart';
import 'package:vinyl_social_network/utils/factory/album_cache_factory.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      const AppConfig(discogsDatasource: DiscogsDatasource(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Album> albums = [];
  bool _checkConfiguration() => true;

  @override
  void initState() {
    super.initState();
    if (_checkConfiguration()) {
      Future.delayed(Duration.zero, () async {
        final pages = await AppConfig.of(context)!
            .discogsDatasource
            .fetchCollectionPages();
        setState(() {
          albums = AlbumCacheFactory.instance.fillAlbumCache(pages);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: albums.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                child: Center(child: Text(albums[index].title)),
              );
            }));
  }
}
