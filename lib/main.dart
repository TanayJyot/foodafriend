import 'package:buildspace_s5/models/user.dart';
import 'package:buildspace_s5/screens/restaurant_wrapper.dart';
import 'package:buildspace_s5/screens/wrapper.dart';
import 'package:buildspace_s5/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:buildspace_s5/themes/theme_provider.dart';
import 'package:buildspace_s5/models/restaurant.dart';
import 'package:buildspace_s5/screens/authenticate/authenticate_restaurant.dart';




Future<void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // runApp(const MyApp());
    runApp(
      MultiProvider(
        providers: [
          // theme provider
          ChangeNotifierProvider(create: (context) => ThemeProvider()),

          // restaurant provider
          ChangeNotifierProvider(create: (context) => Restaurant()),
        ],
        child: const MyApp(),
      ),
    );
  }



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
        // title: 'Flutter Demo',
        // theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
    //     // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    //
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, __) => null,
      child: MaterialApp(
        // Hasnain
        // home: OrderTrackingPage(sourceLocation: sourceLocation, destination: destination),

        // Tanay
        // home: Wrapper(),
          // Restaurant
        home: RestaurantWrapper(),


        //Akshatt

        // debugShowCheckedModeBanner: false,
        // home: const HomePage(),
        // theme: Provider.of<ThemeProvider>(context).themeData,
      ),
    );
  }
}
