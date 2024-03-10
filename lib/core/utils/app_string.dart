// ignore_for_file: constant_identifier_names

class AppString {
  static const Makkah = 'مكيه';
  static const Asr = 'العصــر';
  static const Fajr = 'الفجــر';
  static const Madinah = 'مدنية';
  static const Lastthird = 'الثلث الأخير';
  static const Midnight = 'منتصف الليل';
  static const Dhuhr = 'الظهــر';
  static const Isha = 'العشــاء';
  static const Sunrise = 'الشــروق';
  static const Maghrib = 'المغــرب';
  static const EasyTafsir = 'التفسير الميسر';
  static const TafsirJalalayn = 'تفسير الجلالين';
  static const TafsirAlSaadi = 'تفسير السعدي';
  static const TafsirIbnKathir = 'تفسير ابن كثير';
  static const TafsirAlWaseetByTantawi = 'تفسير الوسيط لطنطاوي';
  static const TafsirAlBaghawi = 'تفسير البغوي';
  static const TafsirAlQurtubi = 'تفسير القرطبي';
  static const TafsirAlTabari = 'تفسير الطبري';
  static String imageName = 'background_fagr';
  static const String badRequest = "Bad Request";
  static const String cacheFailure = 'Cache Failure';
  static const String serverFailure = 'Server Failure';
  static const String unexpectedError = 'Unexpected Error';
  static const String conflictOccurred = "Conflict Occurred";
  static const String internalServerError = "Internal Server Error";
  static const String noInternetConnection = 'No Internet connection';
  static const String requestedInfoNotFound = "Requested Info Not Found";
  static const String errorDuringCommunication = "Error During Communication";
  static const String errorTafsir =
      'لا يوجد تفسير لهذه الآية. يرجى التحقق من الآية أو المحاولة مرة أخرى في وقت لاحق.';
}


List<String> tafsirNameList = [
  AppString.EasyTafsir,
  AppString.TafsirJalalayn,
  AppString.TafsirAlSaadi,
  AppString.TafsirIbnKathir,
  AppString.TafsirAlWaseetByTantawi,
  AppString.TafsirAlBaghawi,
  AppString.TafsirAlQurtubi,
  AppString.TafsirAlTabari
];
