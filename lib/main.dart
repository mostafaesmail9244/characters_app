import 'package:character/app_router.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(BreakingBadApp(
    appRouter: AppRouter(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({required this.appRouter, super.key});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) =>
          MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRout,
      ),
    );
  }
}
