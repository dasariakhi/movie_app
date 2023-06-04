import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'movies.dart';

class provider extends ChangeNotifier {
  var listOfTvShows;
  var getdata;
  var listOfTvMovies;
  late final thumbnailUrl;
  var favouriteItems;
  var listOfPeople;
  var updatedItemList;
  var videos;
  var box;
  var displayName;
  var photoURL;
  var movieIdForVideos;
  var movieId;
  bool successful_login = false;
  sigInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      // Retrieve the user's display name and profile image URL
      displayName = user.displayName;

      photoURL = user.photoURL;

      successful_login = true;

      notifyListeners();

      // Print or use the retrieved information as desired
      print('Username: $displayName');
      print('Profile Image URL: $photoURL');
    }

    return userCredential;
  }

  Future<void> signOutFromGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
      print('User signed out successfully.');
      displayName = 'UserName';
      photoURL = "";
      print('Username: $displayName');
      print('Profile Image URL: $photoURL');
      successful_login = false;
      notifyListeners();
    } catch (e) {
      print('Error occurred while signing out: $e');
    }
  }

  void addItemsToList(List<Movies> items) async {
    box = await Hive.openBox('favorite');

    // Get the existing list or create a new one
    var itemList =
        box.get('itemList', defaultValue: <dynamic>[]) as List<dynamic>;

    // Add the new items to the list
    for (var item in items) {
      if (!itemList.contains(item)) {
        print("new");
        itemList.add(item);
      } else {
        print("old");
      }
    }
    // Save the updated list back to the box
    await box.put('itemList', itemList);

    // Check if items were added successfully
    updatedItemList =
        box.get('itemList', defaultValue: <dynamic>[]) as List<dynamic>;

    if (listEquals(itemList, updatedItemList)) {
      print('Items added successfully! $updatedItemList');
      favouriteItems = updatedItemList;
      notifyListeners();
      // print(box.get('itemList'));
    } else {
      print('Failed to add items.');
    }
  }

  void deleteItemFromList(List<Movies> items) async {
    var box = await Hive.openBox('favorite');

    var itemList =
        box.get('itemList', defaultValue: <dynamic>[]) as List<dynamic>;
    for (var item in items) {
      if (itemList.contains(item)) {
        // Find the index of the item in the list
        var index = itemList.indexOf(item);
        await box.delete(item.name);
        await box.delete(item.description);
        itemList.removeAt(index);
      }
    }

    print('Items deleted successfully.');
    // updatedItemList =
    //     box.get('itemList', defaultValue: <dynamic>[]) as List<dynamic>;

    // // Print the updated list
    // print('Updated List:');
    // for (var item in updatedItemList) {
    //   print(item);
    // }
    await box.put('itemList', itemList);
    // Optional: Print the updated list for verification
    favouriteItems = box.get('itemList');
    notifyListeners();
    await box.close();
  }

  // void deleteItemFromList(List<Movies> item) async {
  //   var box = await Hive.openBox('favorite');
  //   var itemList =
  //       box.get('itemList', defaultValue: <dynamic>[]) as List<dynamic>;

  //   // Find and remove the item from the list
  //   itemList.removeWhere((existingItem) => existingItem == item);

  //   // Save the updated list back to the box
  //   await box.put('itemList', itemList);
  //   print('Item deleted successfully.');

  //   // Optional: You can print the updated list for verification
  //   print(box.get('itemList'));
  // }

  Future<List<dynamic>> getUpdatedItemList() async {
    var box = await Hive.openBox('favorite');
    var updatedItemList =
        box.get('itemList', defaultValue: <dynamic>[]) as List<dynamic>;
    print("update $updatedItemList");
    favouriteItems = updatedItemList;
    // notifyListeners();
    return updatedItemList;
  }

  // Future<List<Movies>> getItemsFromHive() async {
  //   var box = await Hive.openBox('favorite');

  //   var itemList =
  //       box.get('itemList', defaultValue: <dynamic>[]) as List<dynamic>;

  //   List<Movies> moviesList = [];

  //   // Retrieve and store the items in the list
  //   for (var item in itemList) {
  //     var movie = Movies(item.name, item.description);
  //     moviesList.add(movie);
  //   }

  //   favouriteItems = moviesList;
  //   return moviesList;
  // }

  // List<Movie> _favoriteMovies = [];

  // List<Movie> get favoriteMovies => _favoriteMovies;
  // void addFavoriteMovie(Movie movie) {
  //   _favoriteMovies.add(movie);
  //   notifyListeners();
  // }

  // void removeFavoriteMovie(Movie movie) {
  //   _favoriteMovies.remove(movie);
  //   notifyListeners();
  // }

  Future<List<dynamic>> getFirstTrendingTVShowName() async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/trending/tv/week?api_key=3d2f52cdd71d68e2cd7b36e2de3d353c');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final tvShows = decoded['results'];
      final firstTVShow = tvShows[0];
      final name = firstTVShow['name'];

      // var listOfMovies = tvShows;
      //print(tvShows[0]['id']);
      return tvShows;
    } else {
      throw Exception('Failed to load trending TV shows');
    }
  }

  String apiKey = "3d2f52cdd71d68e2cd7b36e2de3d353c";
  Future<void> fetchTrending() async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/trending/all/day?api_key=3d2f52cdd71d68e2cd7b36e2de3d353c');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = response.body;
      final decodedData = jsonDecode(data);
      final results = decodedData['results'];
      getdata = results;
      movieId = results[1]['id'];

      notifyListeners();
    } else {
      throw Exception('No movie results found');
    }
  }

  Future<List<dynamic>> fetchMovieVideos() async {
    // int movieId = await getdata[1]['id'];

    final apiKey = '3d2f52cdd71d68e2cd7b36e2de3d353c';
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/603692/videos?api_key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print(decoded);
      videos = decoded['results'] as List<dynamic>;

      print("mo videos $videos");
      return videos;
    } else {
      throw Exception('Failed to load movie videos');
    }
  }
}



  // void main() async {
  //   try {
  //     final name = await getFirstTrendingTVShowName();

  //     print(name);
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

