import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

  String get fullName => '$firstName $lastName';
}

// User Provider untuk state management
class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  String _selectedUserName = 'Selected User Name';
  int _currentPage = 1;
  int _totalPages = 0;
  bool _isLoading = false;
  bool _hasMoreData = true;
  final int _perPage = 10;

  // Getters
  List<User> get users => _users;
  String get selectedUserName => _selectedUserName;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;
  bool get isEmpty => _users.isEmpty;

  // Set selected user
  void setSelectedUser(String userName) {
    _selectedUserName = userName;
    notifyListeners();
  }

  // Reset selected user
  void resetSelectedUser() {
    _selectedUserName = 'Selected User Name';
    notifyListeners();
  }

  // Fetch users from API
  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      if (isRefresh) {
        _users.clear();
        _currentPage = 1;
        _hasMoreData = true;
      }

      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$_currentPage&per_page=$_perPage'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<User> newUsers = (data['data'] as List)
            .map((userJson) => User.fromJson(userJson))
            .toList();

        _users.addAll(newUsers);
        _totalPages = data['total_pages'] ?? 0;
        _hasMoreData = _currentPage < _totalPages;
        _currentPage++;
      }
    } catch (e) {
      print('Error fetching users: $e');

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load more users (untuk pagination)
  Future<void> loadMoreUsers() async {
    if (!_hasMoreData || _isLoading) return;
    await fetchUsers();
  }

  // Refresh users
  Future<void> refreshUsers() async {
    await fetchUsers(isRefresh: true);
  }

  // Clear all data
  void clearUsers() {
    _users.clear();
    _currentPage = 1;
    _totalPages = 0;
    _hasMoreData = true;
    _selectedUserName = 'Selected User Name';
    notifyListeners();
  }

  // Get user by ID
  User? getUserById(int id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search users by name
  List<User> searchUsers(String query) {
    if (query.isEmpty) return _users;

    return _users.where((user) {
      final fullName = user.fullName.toLowerCase();
      final email = user.email.toLowerCase();
      final searchQuery = query.toLowerCase();

      return fullName.contains(searchQuery) || email.contains(searchQuery);
    }).toList();
  }
}