
import 'package:bookingapp/provider/hotel_provider.dart';
import 'package:bookingapp/provider/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'page/empty/index.dart';
import 'services/themes.dart';
import 'package:bookingapp/routers/routers.dart' as RouterGen;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_application/secure_application.dart';




final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 final SecureApplicationController _secureApplicationController = SecureApplicationController(SecureApplicationState());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => HotelProvider()),
              ChangeNotifierProvider(create: (_) => ScheduleProvider()),
            ],
            child: MaterialApp(
              title: 'Booking App',
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Inter',
                primaryColor: Color(primaryColor),
                appBarTheme: appBarThemeCollapse(),
                scaffoldBackgroundColor: Color(0xFFFBFCFD),
                indicatorColor: Color(0xFFBD202E),
                textTheme: TextTheme(
                  labelSmall: TextStyle(letterSpacing: 0.02, fontWeight: FontWeight.w600),
                  bodyLarge: TextStyle(fontWeight: FontWeight.w600),
                  bodyMedium: TextStyle(fontWeight: FontWeight.w600),
                  bodySmall: TextStyle(fontWeight: FontWeight.w600),
                  titleLarge: TextStyle(fontWeight: FontWeight.w600),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Color(primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(background: Color(0xFFFBFCFD)),
                bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFFBD202E)),
              ),
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(MediaQuery.textScaleFactorOf(context).clamp(1.0, 1.3))),
                  child: SecureApplication(
                    secureApplicationController: _secureApplicationController,
                    nativeRemoveDelay: 300,
                    child: SecureGate(child: child!),
                  ),
                );
              },
              navigatorObservers: [
                routeObserver
              ],
              onGenerateRoute: RouterGen.Router.generateRoute,
              onUnknownRoute: (settings) => MaterialPageRoute(
                settings: settings,
                builder: (_) => EmptyPage(),
              ),
            ),
          );
        });
  }

  AppBarTheme appBarThemeCollapse() {
    return AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      centerTitle: true,
      elevation: 0,
      color: Colors.white,
    );
  }
}
