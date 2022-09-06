import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:grocery_store/models/http_exception.dart';
import 'package:hive/hive.dart';
import '../app_constants/app_constants.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userID;
  Timer? _authTimer;

  bool get isAuth {
    tryAutoLogin();
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userID => _userID;

  Box<String> get authBox => Hive.box<String>(AppConstants.authBox);

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, AppConstants.signUp);
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, AppConstants.signIn);
  }

  Future<void> _authenticate(
      String email, String password, String method) async {
    final url = Uri.parse(AppConstants.authUrl + method + AppConstants.apiKey);

    try {
      final response = await http.post(url,
          body: jsonEncode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));

      final responseData = jsonDecode(response.body);
      // print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userID = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      AppConstants.token = _token!;
      AppConstants.userID = _userID!;
      _autoLogOut();
      notifyListeners();

      final authData = jsonEncode({
        'email': email,
        'password': password,
        'token': _token,
        'userID': _userID,
        'expiryDate': _expiryDate?.toIso8601String(),
      });

      // final data = jsonDecode(authBox.get('authData')!);
      // print('${data['token']} \n ${data['userID']} ');

      authBox.put('authData', authData);

    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async{
    if(!authBox.containsKey('authData')){
      return false;
    }

    final data = jsonDecode(authBox.get('authData')!);
    final expiryDate = DateTime.parse(data['expiryDate']);

    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }

    _token = data['token'];
    _userID = data['userID'];
    AppConstants.token = _token!;
    AppConstants.userID = _userID!;
    _expiryDate = expiryDate;
    // notifyListeners();
    return true;
}

  void logOut(){
    _token = null;
    _userID = null;
    _expiryDate = null;
    authBox.clear();
    AppConstants.token = '';
    AppConstants.userID = '';
    notifyListeners();
  }

   Future<void> _refreshToken() {
    final data = jsonDecode(authBox.get('authData')!);
    final email = data['email'];
    final password = data['password'];
    return _authenticate(email, password, AppConstants.signIn);
  }

  void _autoLogOut() {
    if(_authTimer != null){
      _authTimer!.cancel();
    }
    final expiryTime = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: expiryTime), _refreshToken);
  }
}
