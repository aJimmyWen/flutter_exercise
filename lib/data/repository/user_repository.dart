import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_users/data/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final http.Client client = http.Client();

  Future<List<User>> fetchUsers() async {
    final url = Uri.https('api.github.com', '/users');
    final response = await client
        .get(url, headers: {'accept': 'application/vnd.github+json'});

    switch (response.statusCode) {
      case 200:
        final data = json.decode(response.body);
        final users = (data as List<dynamic>).map((user) {
          return User(
            id: user['id'] ?? '',
            avatarUrl: user['avatar_url'] ?? '',
            login: user['login'],
            siteAdmin: user['site_admin'] ?? false,
          );
        }).toList();

        return users;
      default:
        throw Exception('Some error occurred');
    }
  }

  Future<UserDetail> getUser(String userName) async {
    final url = Uri.https('api.github.com', '/users/$userName');
    final response = await client
        .get(url, headers: {'accept': 'application/vnd.github+json'});

    switch (response.statusCode) {
      case 200:
        final data = json.decode(response.body);
        final user = UserDetail(
            avatarUrl: data['avatar_url'] ?? '',
            name: data['name'] ?? '',
            bio: data['bio'] ?? '',
            login: data['login'] ?? '',
            siteAdmin: data['site_admin'] ?? false,
            location: data['location'] ?? '',
            blog: data['blog'] ?? '');
        return user;
      default:
        throw Exception('Some error occurred');
    }
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});
