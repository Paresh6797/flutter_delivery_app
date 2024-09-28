import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../logic/debug/app_bloc_observer.dart';
import '../../presentation/routers/app_router.dart';
import '../themes/app_theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {

    return kReleaseMode
        ? _releaseWidget(context)
        : _debugWidget(context);
  }
}

// /// release mode material app.
_releaseWidget(BuildContext context) => MaterialApp(
  title: "Food App",
  theme: appLightTheme(context),
  themeMode: ThemeMode.light,
  debugShowCheckedModeBanner: false,
  navigatorKey: AppRouter.navigatorKey,
  initialRoute: AppRouter.home,
  onGenerateRoute: AppRouter.onGenerateRoute,
  builder: (context, child) {
    var responsiveChild = _responsiveWrapperWidget(context, child!);
    return responsiveChild;
  },
);
//
// /// debug mode material app.
_debugWidget(BuildContext context) => BlocOverrides.runZoned(
        () => DevicePreview(
      enabled: false,
      builder: (context) => MaterialApp(
        title: "Food App",
        useInheritedMediaQuery: true,
        theme: appLightTheme(context),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        navigatorKey: AppRouter.navigatorKey,
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
        builder: (context, child) {
          var responsiveChild = _responsiveWrapperWidget(context, child!);
          var dchild = DevicePreview.appBuilder(context, responsiveChild);
          return dchild;
        },
      ), // Wrap your app
    ),
    blocObserver: AppBlocObserver());

/// used to make responsive. set breakpoint here.
_responsiveWrapperWidget(BuildContext context, Widget child) =>
    ResponsiveWrapper.builder(
      ClampingScrollWrapper.builder(context, child),
      breakpoints: [
        const ResponsiveBreakpoint.resize(320, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(450, name: TABLET),
      ],
    );