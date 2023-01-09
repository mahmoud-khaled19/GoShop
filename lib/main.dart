import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login%20screen/shop_login.dart';
import 'package:shop_app/shared/components/constans.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/bloc%20observer.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/network/remote/dio.dart';
import 'package:shop_app/style/themes.dart';
import 'modules/boarding_screen/boarding-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  bool? isDark = CacheHelper.getData(key: 'isDark');
  token = CacheHelper.getData(key: 'token');
  if (kDebugMode) {
    print(token);
  }
  Widget widget;
  if (onBoarding != null) {
    if (token.length <= 2) {
      widget = const ShopAppLoginScreen();
    } else {
      widget = const ShopLayout();
    }
  } else {
    widget = const ShopAppBoardingScreen();
  }
  runApp(MyApp(isDark, widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  final bool? isDark;

  MyApp(this.isDark, this.widget, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopCubit()
          ..changeShopTheme(fromShared: isDark)
          ..homeModel(),
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightMode,
              darkTheme: darkMode,
              themeMode: ShopCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: widget,
            );
          },
        ));
  }
}
