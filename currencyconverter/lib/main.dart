import 'dart:async';
import 'package:flutter/material.dart';
import 'btcconverter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      /*title: 'BTC Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),*/
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (content) => const BTCScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 119, 133, 214),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              const Text("Welcome to",
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 66, 59, 142))),
              const SizedBox(height: 10),
              Image.asset('assets/images/mylogo.png', scale: 2),
              const SizedBox(height: 10),
              const Text("BTC Currency Converter",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
