import 'package:flutter/material.dart';
import 'package:movie_app_provider_atha/page/movie_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        footerBuilder: () => const ClassicFooter(
              loadingIcon: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    strokeWidth: 2,
                  )),
            ),
        headerBuilder: () => const WaterDropMaterialHeader(
              backgroundColor: Colors.blue,
              distance: 40,
            ),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: MoviePage(),
        ));
  }
}
