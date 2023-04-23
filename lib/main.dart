import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/app_constance/theme_manager.dart';
import 'package:shop_app/view/screens/auth/login%20screen/shop_login.dart';
import 'package:shop_app/view/screens/home/layout/shop_layout.dart';
import 'package:shop_app/view/screens/splash-screen/splash_screen.dart';
import 'package:shop_app/view_model/cubit/app_cubit.dart';
import 'package:shop_app/view_model/cubit/app_states.dart';
import 'package:shop_app/view_model/cubit/bloc%20observer.dart';
import 'package:shop_app/view_model/shared/network/local/shared_preferences.dart';
import 'package:shop_app/view_model/shared/network/remote/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark')?? true;
  AppMethods.token = CacheHelper.getData(key: 'token');
  Widget widget;
  if (AppMethods.token == null) {
    widget =  ShopAppLoginScreen();
  } else {
    widget = const ShopLayout();
  }
  runApp(EasyLocalization(
    useOnlyLangCode: true,
    saveLocale: true,
    supportedLocales: const [
      Locale(
        'en',
      ),
      Locale(
        'ar',
      ),
    ],
    fallbackLocale: const Locale('ar'),
    path: 'assets/translations',
    child: MyApp(isDark),
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp(this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopCubit()
          ..homeModel()
          ..changeShopTheme(fromShared: isDark)
          ..categoryModel()
          ..getFavoritesItems()
          ..getUserdata()
          ..getCartsItems(),
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              localeResolutionCallback: (deviceLocale, supportLocales) {
                for (var locale in supportLocales) {
                  if (deviceLocale != null &&
                      deviceLocale.languageCode == locale.languageCode) {
                    return deviceLocale;
                  }
                }
              },
              title: AppStrings.appTitle.tr(),
              debugShowCheckedModeBanner: false,
              theme: ShopCubit.get(context).isDark
                  ? getLightApplicationTheme()
                  : getDarkApplicationTheme(),
              home: const SplashScreen(),
            );
          },
        ));
  }
}
