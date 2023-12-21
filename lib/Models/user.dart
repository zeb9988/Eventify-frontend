import 'dart:convert';

class User {
  final String id;
  late final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final String? fcm_token;
  final List<dynamic> cart;
  final List<dynamic> favorites;
  double wallet; // New field for the wallet balance

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.fcm_token,
    required this.cart,
    required this.favorites,
    this.wallet = 0.0, // Default wallet balance is set to 0.0
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'fcm_token': fcm_token,
      'cart': cart,
      'favorites': favorites,
      'wallet': wallet, // Include wallet balance in the map
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      fcm_token: map['fcm_token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      favorites: List<Map<String, dynamic>>.from(
        map['favorites']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      wallet: map['wallet']?.toDouble() ?? 0,
      // orderedAt: map['orderedAt']?.toInt() ?? 0,
      // Retrieve wallet balance from the map
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    String? fcm_token,
    List<dynamic>? cart,
    List<dynamic>? favorites,
    double? wallet, // Include wallet balance in the copyWith method
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      fcm_token: fcm_token ?? this.fcm_token,
      cart: cart ?? this.cart,
      favorites: favorites ?? this.favorites,
      wallet: wallet ?? this.wallet, // Update the wallet balance in copyWith
    );
  }
}
