// import 'dart:async';
import 'package:eventify/Language/language_constants.dart';
import 'package:eventify/common/widgets/splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:eventify/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GlobalKey<NavigatorState>? navigatorKey;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51O53xnInF3xMZni1WQz4mvPAu3OKL3Fz5tIwt9kUYmbCbZrDTFAX6MsJ7SbOr7RNmdvEW7zhAN67IbHZ3yobJ5Yi00XaVfDIfl';
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken != null) {
      print("gettoken : $fcmToken");
      prefs.setString('fcmToken', fcmToken);
    } else {
      print("Failed to retrieve FCM token");
    }
  } catch (e) {
    print("Error getting FCM token: $e");
  }

  print(prefs.getString('fcmToken'));

  final InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings(
        '@mipmap/ic_launcher'), // Replace with your app's launcher icon
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
    ChangeNotifierProvider(create: (_) => FavoritesProvider())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    // localization
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale; // localization

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  // final AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    // auth.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        // themeMode: ThemeMode.dark,
        // theme: ThemeData.dark(),
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        // darkTheme: darkTheme,

        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        debugShowCheckedModeBanner: false,
        title: 'My App',
        //themeMode: ThemeMode.system,
        // initialRoute: SplashScreen.id,
        onGenerateRoute: (settings) => generateRoute(settings),
        home: SplashScreen()
        // Provider.of<UserProvider>(context).user.token.isNotEmpty
        //     ? Provider.of<UserProvider>(context).user.type == "admin"
        //     ? Adminscreen()
        //     : IntroScreen()
        //     : LandingPage(),
        // show ? IntroScreen() : const HomeScreen(),
        // Set SplashScreen as the initial route
        );
  }
}
