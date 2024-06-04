import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import '../models/app_config.dart';
import '../services/http_service.dart';
import '../services/movie_service.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({Key? key, required this.onInitializationComplete})
      : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _setup(context).then((_) {
      widget.onInitializationComplete();
    });
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;
    try {
      final configFile = await rootBundle.loadString('assets/config/main.json');
      final configData = jsonDecode(configFile);

      // Print the loaded config data for debugging
      print('Loaded config data: $configData');

      // Check if all required keys are present in config data
      if (configData.containsKey('BASE_API_URL') &&
          configData.containsKey('BASE_IMAGE_API_URL') &&
          configData.containsKey('API_KEY')) {
        getIt.registerSingleton<AppConfig>(
          AppConfig(
            BASE_API_URL: configData['BASE_API_URL'],
            BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
            API_KEY: configData['API_KEY'],
          ),
        );

        getIt.registerSingleton<HTTPService>(HTTPService());
        getIt.registerSingleton<MovieService>(MovieService());

        print('Services registered successfully');
      } else {
        // Throw an error if any required key is missing
        throw Exception('Incomplete config data');
      }
    } catch (e) {
      print('Error during setup: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assets/images/logo.png"),
            ),
          ),
        ),
      ),
    );
  }
}
