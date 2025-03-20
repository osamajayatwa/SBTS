class AppLink {
  static const String server =
      "";

  static const String imageststatic = "$server/upload";

//========================== Image ============================

// =============================================================
  static const String notification = "$server/";
  static const String deleteFcmToken = "$server/ParentLogout";

  static const String trackingpage = "$server/TrackBus";
  static const String childstatus = "$server/ABSENCE_OR_NOT";
// ================================= Auth ========================== //
  static const String logindata = "$server/ParentLogin";
  static const String reset = "$server/ResetPassForParent";
  static const String signupdata = "$server/";
  static const String verifysignupdata = "$server/";
  static const String resend = "$server/";

// ================================= ForgetPassword ==========================//
  static const String token = "$server/UpdateToken";
  static const String checkEmail = "$server/";

  static const String forgetverifycode = "$server/";
// =================================== Home ==========================//
  static const String homepage = "$server/StdForParent";
  static const String location = "$server/GetLonLatForParent";
  static const String getroundsstd = "$server/GetRoundsForEachStd";
  static const String addressView = "$server/GetRoundsForEachStd";
  static const String addressAdd = "$server/GetRoundsForEachStd";
  static const String addressDelete = "$server/GetRoundsForEachStd";
}
