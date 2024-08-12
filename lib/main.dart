import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_rnb/screens/home/home_screen.dart';
import 'package:test_rnb/screens/home/picker_screen.dart';
import 'package:test_rnb/screens/login/login_screen.dart';
import 'package:test_rnb/screens/register/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: 'AIzaSyBUtm-K-gvkRke7IWtgMqc3bJ61_oMst1I',
    appId: '1:822777073971:android:567edf662586871e7cae46',
    projectId: 'crud-test-67b66',
    messagingSenderId: '822777073971',
    storageBucket: 'crud-test-67b66.appspot.com',
    // Tambahkan opsi lain jika diperlukan
  );

  try {
    await Firebase.initializeApp(options: firebaseOptions);
  } catch (e) {
    // Handle the error here
    print('Error initializing Firebase: $e');
  }

  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const MyApp());
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
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
