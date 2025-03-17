import 'package:bus_tracking_users/view/screen/Auth/signup.dart';
import 'package:bus_tracking_users/view/screen/Auth/successsignUp.dart';
import 'package:bus_tracking_users/view/screen/Auth/verifysignupcode.dart';
import 'package:bus_tracking_users/view/screen/Drawer/contact_us.dart';
import 'package:bus_tracking_users/view/screen/Drawer/Terms.dart';
import 'package:bus_tracking_users/view/screen/Drawer/about_us.dart';
import 'package:bus_tracking_users/core/constant/routes.dart';
import 'package:bus_tracking_users/core/mymiddleware/middleware.dart';
import 'package:bus_tracking_users/view/screen/address/add_details.dart';
import 'package:bus_tracking_users/view/screen/profile/profile.dart';
import 'package:bus_tracking_users/view/screen/Auth/login.dart';
import 'package:bus_tracking_users/view/screen/forgetpass/forget_password.dart';
import 'package:bus_tracking_users/view/screen/forgetpass/reset_password.dart';
import 'package:bus_tracking_users/view/screen/forgetpass/success_reset_pass.dart';
import 'package:bus_tracking_users/view/screen/home/home_screen.dart';
import 'package:bus_tracking_users/view/screen/splash%20screens/language.dart';
import 'package:bus_tracking_users/view/screen/notification.dart';
import 'package:bus_tracking_users/view/screen/splash%20screens/onbording.dart';
import 'package:bus_tracking_users/view/screen/rides.dart';
import 'package:bus_tracking_users/view/screen/tracking.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/", page: () => const Language(), middlewares: [MyMiddleware()]),

  //Auth
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.verfiyCode, page: () => const VerifySignUp()),

  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),

  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(
      name: AppRoute.successResetpassword,
      page: () => const SuccessResetPass()),

  GetPage(name: AppRoute.homepage, page: () => const HomeScreen()),

  GetPage(name: AppRoute.notification, page: () => const NotificationView()),
  GetPage(name: AppRoute.onBoarding, page: () => const OnBording()),
  GetPage(
    name: AppRoute.rides,
    page: () => ListRides(),
  ),

  GetPage(name: AppRoute.profile, page: () => const Profile()),
  GetPage(name: AppRoute.ridestracking, page: () => const Tracking()),
  GetPage(name: AppRoute.terms, page: () => const TermsPage()),
  GetPage(name: AppRoute.contactus, page: () => ContactUs()),
  GetPage(name: AppRoute.aboutus, page: () => const AboutUs()),
  GetPage(name: AppRoute.homeaddress, page: () => const AddressAdd()),
];
