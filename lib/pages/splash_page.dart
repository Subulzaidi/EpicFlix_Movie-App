// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers
import 'dart:convert';
//packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

//service
import '../services/http_service.dart';
import '../services/movie_service.dart';

//model
import '../models/app_config.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({super.key, required this.onInitializationComplete});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Simulate some initialization work
    Future.delayed(Duration(seconds: 1)).then(
      (_) => _setup(context).then((_) {
        print('Initialization complete');
        widget.onInitializationComplete();
      }),
    );
  }

  Future<void> _setup(BuildContext _context) async {
    final getIt = GetIt.instance;
    try {
      print('Loading config file');
      final configFile = await rootBundle.loadString('assets/config/main.json');
      final configData = jsonDecode(configFile);
      print('Config file loaded: $configData');

      getIt.registerSingleton<AppConfig>(
        AppConfig(
          BASE_API_URL: configData['BASE_API_URL'],
          BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
          API_KEY: configData['API_KEY'],
        ),
      );
      getIt.registerSingleton<HTTPService>(
        HTTPService(),
      );
      getIt.registerSingleton<MovieService>(
        MovieService(),
      );
      print('Services registered');
    } catch (e) {
      print('Error during setup: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EpicFlix',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
