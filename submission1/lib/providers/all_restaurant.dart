import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:submission1/database/database_helper.dart';
import 'package:submission1/model/favorite.dart';

enum ResultState { initial, loading, hasdData, nodata }

class RestauranProvider extends ChangeNotifier {
  List<dynamic> _allrestauran = [];
  List<dynamic> _review = [];
  List<dynamic> _favorite = [];
  List<dynamic> _setfavorite = [];
  List<dynamic> _restaurant = [];
  late DatabaseHelper _databaseHelper;
  bool _internet = false;

  ResultState state = ResultState.initial;

  ResultState get getState => state;

  bool get internet => _internet;

  Map<String, dynamic> _detailres = {};

  Map<String, dynamic> get detailres => _detailres;

  List<dynamic> get review => _review;

  List<dynamic> get favorite => _favorite;

  void searchFavorite(String query) {
    state = ResultState.loading;
    _favorite = _setfavorite.where((restaurant) {
      final name = restaurant.name.toLowerCase();
      final city = restaurant.city.toLowerCase();
      final search = query.toLowerCase();

      return name.contains(search) || city.contains(search);
    }).toList();
    if (_favorite.isEmpty) {
      state = ResultState.nodata;
    } else {
      state = ResultState.hasdData;
    }
    notifyListeners();
  }

  List<dynamic> get restauran => _restaurant;

  List<dynamic> get allrestauran {
    return _allrestauran;
  }

  RestauranProvider() {
    _databaseHelper = DatabaseHelper();
    getFavorite();
  }

  void searchRestauran(String query) async {
    state = ResultState.loading;
    final status = await Connectivity().checkConnectivity();
    if (status != ConnectivityResult.none) {
      Uri url =
          Uri.parse("https://restaurant-api.dicoding.dev/search?q=" + query);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _allrestauran = (jsonDecode(response.body))['restaurants'];
        if (_allrestauran.isEmpty) {
          state = ResultState.nodata;
        } else {
          state = ResultState.hasdData;
        }
        _internet = true;
        notifyListeners();
      }
    } else {
      _internet = false;
      notifyListeners();
    }
  }

  void restauranAPI() async {
    state = ResultState.loading;
    final status = await Connectivity().checkConnectivity();
    if (status != ConnectivityResult.none) {
      Uri url = Uri.parse("https://restaurant-api.dicoding.dev/list");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _allrestauran = (jsonDecode(response.body))['restaurants'];
        _restaurant = (jsonDecode(response.body))['restaurants'];
        state = ResultState.hasdData;
        _internet = true;
        notifyListeners();
      }
    } else {
      _internet = false;
      notifyListeners();
    }
  }

  void detailRestauran(String id) async {
    state = ResultState.loading;
    final status = await Connectivity().checkConnectivity();
    if (status != ConnectivityResult.none) {
      Uri url = Uri.parse("https://restaurant-api.dicoding.dev/detail/" + id);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _detailres = (jsonDecode(response.body))['restaurant'];
        _review = _detailres['customerReviews'];
        _internet = true;
        state = ResultState.hasdData;
        notifyListeners();
      }
    } else {
      _internet = false;
      notifyListeners();
    }
  }

  void addReview(Map<String, String> data) async {
    final status = await Connectivity().checkConnectivity();
    if (status != ConnectivityResult.none) {
      Uri url = Uri.parse("https://restaurant-api.dicoding.dev/review");
      String body = json.encode(data);
      final response = await http.post(
        url,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        _review = jsonDecode(response.body);
        _internet = true;
        notifyListeners();
      }
    } else {
      _internet = false;
      notifyListeners();
    }
  }

  void getFavorite() async {
    state = ResultState.loading;
    _favorite = await _databaseHelper.getNotes();
    _setfavorite = _favorite;
    if (_favorite.isEmpty) {
      state = ResultState.nodata;
    } else {
      state = ResultState.hasdData;
    }
    notifyListeners();
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    await _databaseHelper.insertNote(restaurant);
    getFavorite();
  }

  void updateRestaurant(Restaurant restaurant) async {
    await _databaseHelper.updateRestaurant(restaurant);
    getFavorite();
  }

  void deleteRestaurant(String id) async {
    await _databaseHelper.deleteRestaurant(id);
    getFavorite();
  }
}
