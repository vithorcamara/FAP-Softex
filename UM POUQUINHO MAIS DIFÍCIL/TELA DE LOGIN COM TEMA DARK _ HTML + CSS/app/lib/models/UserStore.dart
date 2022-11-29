import 'package:flutter/material.dart';
import 'package:movienight/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movienight/services/api.dart';
import 'movie.dart';
import 'package:localstore/localstore.dart';

class UserStore extends ChangeNotifier {
  late User? user;
  final db = Localstore.instance;
  String token = '';

  Future<http.Response> login(String username, String password) async {
    http.Response response = await Api.post('/auth/login', {
      "username": username,
      "password": password,
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body)['user'];
      user = User.fromJson(userData);
      token = json.decode(response.body)['token'];
      db
          .collection('token')
          .doc(user!.id)
          .set({'token': json.decode(response.body)['token']});

      // Saves to localstorage
      db
          .collection('user')
          .doc(user!.id)
          .set(json.decode(response.body)['user']);
      notifyListeners();
    }
    return response;
  }

  Future<http.Response> updateUser(String username) async {
    http.Response response = await Api.put('/user', {
      "username": username,
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body)['user'];
      user = User.fromJson(userData);

      // Saves to localstorage
      db
          .collection('user')
          .doc(user!.id)
          .set(json.decode(response.body)['user']);
      notifyListeners();
    }
    return response;
  }

  Future<http.Response> deleteAccount(String username) async {
    http.Response response = await Api.delete('/user', params:{
      "username": username,
    });
    if (response.statusCode == 200) {
      db.collection('token').doc(user!.id).delete();
      db.collection('user').doc(user!.id).delete();
      user = null;
      token = '';
      notifyListeners();
    }
    return response;
  }

  Future<http.Response> logout() async {
    http.Response response = await Api.get('/auth/logout');
    if (response.statusCode == 200) {
      // Saves to localstorage
      db.collection('token').doc(user!.id).delete();
      db.collection('user').doc(user!.id).delete();
      user = null;
      token = '';
      notifyListeners();
    }
    return response;
  }

  Future<bool> hasUserOnLocalStorage() async {
    final db = Localstore.instance;
    return db.collection('user').get().then((value) {
      if (value != null) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> getUserFromLocalStorage() async {
    final db = Localstore.instance;
    db.collection('user').get().then((value) {
      if (value != null) {
        user = User.fromJson(value.entries.first.value);
      }
    });
    return db.collection('token').get().then((value) {
      if (value != null) {
        token = value.entries.first.value['token'];
        return true;
      }
      return false;
    });
  }

  Future<http.Response> insertMovie(Movie movie) async {
    http.Response response = await Api.post('/movies', {
      'id': movie.id,
      'title': movie.title,
      'popularity': movie.popularity,
      'posterPath': movie.posterPath,
      'overview': movie.overview,
      'status': movie.status,
      'tagline': movie.tagline,
      'voteAverage': movie.voteAverage,
      'realeaseDate': movie.realeaseDate,
      'runtime': movie.runtime,
    });
    if (response.statusCode == 201) {
      final Map<String, dynamic> userData = json.decode(response.body)['user'];
      user = User.fromJson(userData);
      // Saves to localstorage
      db
          .collection('user')
          .doc(user!.id)
          .set(json.decode(response.body)['user']);
      notifyListeners();
    }
    return response;
  }

  Future<http.Response> removeMovie(int id) async {
    http.Response response = await Api.delete('/movies', params: {
      'id': id.toString(),
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body)['user'];
      user = User.fromJson(userData);
      // Saves to localstorage
      db
          .collection('user')
          .doc(user!.id)
          .set(json.decode(response.body)['user']);
      notifyListeners();
    }
    return response;
  }

  void addWatchMovie(Movie movie) {
    user!.addWatchMovie(movie);
    notifyListeners();
  }

  void removeWatchMovie(Movie movie) {
    user!.removeWatchMovie(movie);
    notifyListeners();
  }
}
