import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googlenav/screens/home_screen.dart';


  class SplashScreen extends StatefulWidget {
    const SplashScreen({super.key});

    @override
    State<SplashScreen> createState() => _SplashScreenState();
  }

  class _SplashScreenState extends State<SplashScreen>
      with SingleTickerProviderStateMixin {

      @override
    void initState() {
      super.initState();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

      Future.delayed( const Duration(seconds: 5), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ));
      });
    }
      @override
    void dispose() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      super.dispose();
    }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.redAccent,Colors.red],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("./images/logo.gif",
                    height: 250.0,
                    width: 250.0,
                  ),
                  const Text('Atak Sistemas',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 32,
                    ),)
                ],
              )
          ),
        );
      }
  }


