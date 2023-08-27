import 'package:foodex_app/dashboard_button.dart';
import 'package:foodex_app/home_button.dart';
import 'package:foodex_app/screen/export_screen.dart';
import 'package:foodex_app/screen/food/category_detail.dart';
import 'package:foodex_app/screen/splash_screen/splashScreen.dart';
import 'package:get/get.dart';

class RouterHelper {
  static const String splashScreen = "/splashScreen";
  static const String initial = '/';
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  static const String dashboardButton = "/dashboardButton";
  static const String dashboard = "/dashboardScreen";
  static const String dashboardScreen = "/dashboard";
  static const String specialFood = "/special-food";
  static const String popularFood = "/popular-food";
  static const String categoryFood = "/category";
  static const String cartScreen = "/cart";

  static String getSplashScreen() => splashScreen;
  static String getInitial() => initial;
  static String getLogin() => loginScreen;
  static String getRegister() => registerScreen;
  static String getDashboardButton() => dashboardButton;
  static String getDashboardScreen() => dashboardScreen;
  static String getDashboard() => dashboardScreen;
  static String getSpecialFood(int pageId, String page) =>
      '$specialFood?pageId=$pageId&page=$page';
  static String getPopularFood() => popularFood;
  static String getCategoryFood() => categoryFood;
  static String getCartScreen() => cartScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: initial, page: () => const DashboardButton()),

    GetPage(
        name: loginScreen,
        page: () {
          return const LoginScreen();
        },
        transition: Transition.fade),

    GetPage(
        name: registerScreen,
        page: () {
          return const SignUpScreen();
        },
        transition: Transition.fade),

    GetPage(
        name: dashboardButton,
        page: () {
          return const DashboardButton();
        }),

    // --------- Special Food
    // GetPage(
    //     name: specialFood,
    //     page: () {
    //       var pageId = Get.parameters['pageId'];
    //       var page = Get.parameters["page"];
    //       return const SpecialFoodDetails();
    //     },
    //     transition: Transition.fadeIn),

    // ---------------- Popular Food
    // GetPage(
    //     name: popularFood,
    //     page: () {
    //       return PopularFoodDetail();
    //     },
    //     transition: Transition.fade),

    // ----------------- Category Food
    GetPage(
        name: categoryFood,
        page: () {
          return const CategoryScreen(null);
        },
        transition: Transition.fade),

    GetPage(
        name: cartScreen,
        page: () {
          return const CartScreen();
        },
        transition: Transition.fade)
  ];
}
