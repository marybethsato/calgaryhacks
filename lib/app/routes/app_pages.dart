import 'package:get/get.dart';

import '../modules/ai/bindings/ai_binding.dart';
import '../modules/ai/views/ai_view.dart';
import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/leaderboards/bindings/leaderboards_binding.dart';
import '../modules/leaderboards/views/leaderboards_view.dart';
import '../modules/navigation/bindings/navigation_binding.dart';
import '../modules/navigation/views/navigation_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/scan/bindings/scan_binding.dart';
import '../modules/scan/views/scan_details_view.dart';
import '../modules/scan/views/scan_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/wildlife_collection/bindings/wildlife_collection_binding.dart';
import '../modules/wildlife_collection/views/wildlife_collection_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthenticationView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => const NavigationView(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: _Paths.SCAN,
      page: () => const ScanView(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_DETAILS,
      page: () => const ScanDetailsView(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: _Paths.AI,
      page: () => const AiView(),
      binding: AiBinding(),
    ),
    GetPage(
      name: _Paths.LEADERBOARDS,
      page: () => const LeaderboardsView(),
      binding: LeaderboardsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.WILDLIFE_COLLECTION,
      page: () => const WildlifeCollectionView(),
      binding: WildlifeCollectionBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: AuthBinding(),
    ),
  ];
}
