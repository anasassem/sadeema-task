import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeematask/constants.dart';
import 'package:sadeematask/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sadeematask/core/utils/setup_service_locator.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/setup_service_locator.dart' as di;

void main() async{
  Bloc.observer = SimpleBlocObserver();
  //setupServiceLocator();

  await di.init();
  runApp(const Bookly());
}

class Bookly extends StatelessWidget {
  const Bookly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(

          scaffoldBackgroundColor: kPrimaryColor,
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.montserratTextTheme(
            ThemeData.light().textTheme,
          ),
        ),
      ),
    );
  }
}
