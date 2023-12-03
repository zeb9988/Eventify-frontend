import 'package:flutter/material.dart';
import '../models/Product.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '',
      fcm_token: '',
      cart: [],
      favorites: []);

  User get user => _user;

  void setUser(String user) {
    if (user != null) {
      _user = User.fromJson(user);
    }
    notifyListeners();
  }

  void updateName(String newName) {
    user.name = newName;
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _user.favorites
        .any((entry) => entry['product']['_id'] == product.id);
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}

class FavoritesProvider with ChangeNotifier {
  List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  void addToFavorites(Product product) {
    if (!_favorites.contains(product)) {
      product.isfav = true;
      _favorites.add(product);
      notifyListeners();
    }
  }

  void removeFromFavorites(Product product) {
    product.isfav = false;
    _favorites.remove(product);
    notifyListeners();
  }
}
