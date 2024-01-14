import 'package:shared_preferences/shared_preferences.dart';

class helperFunctions {
  // User keys
  static String userLoggedInKey = 'LOGGEDINKEY';
  static String userNameKey = 'USERNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';

  // Location keys
  static String latitudeKey = 'LATITUDE_KEY';
  static String longitudeKey = 'LONGITUDE_KEY';
  static String localityKey = 'LOCALITY_KEY';
  static String subLocalityKey = 'SUB_LOCALITY_KEY';
  static String countryKey = 'COUNTRY_KEY';

  // Saving user data with SharedPreferences

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUsernameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  // Getting user data from SharedPreferences

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  // Saving location data with SharedPreferences

  static Future<bool> saveLatitude(double latitude) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setDouble(latitudeKey, latitude);
  }

  static Future<bool> saveLongitude(double longitude) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setDouble(longitudeKey, longitude);
  }

  static Future<bool> saveLocality(String locality) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(localityKey, locality);
  }

  static Future<bool> saveSubLocality(String subLocality) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(subLocalityKey, subLocality);
  }

  static Future<bool> saveCountry(String country) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(countryKey, country);
  }

  // Getting location data from SharedPreferences

  static Future<double?> getLatitude() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getDouble(latitudeKey);
  }

  static Future<double?> getLongitude() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getDouble(longitudeKey);
  }

  static Future<String?> getLocality() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(localityKey);
  }

  static Future<String?> getSubLocality() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(subLocalityKey);
  }

  static Future<String?> getCountry() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(countryKey);
  }
}
