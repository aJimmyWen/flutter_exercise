class User {
  final String login;
  final int id;
  final String avatarUrl;
  final bool siteAdmin;

  User({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.siteAdmin,
  });
}

class UserDetail {
  final String avatarUrl;
  final String name;
  final String bio;
  final String login;
  final bool siteAdmin;
  final String location;
  final String blog;

  UserDetail({
    required this.avatarUrl,
    required this.name,
    required this.bio,
    required this.login,
    required this.siteAdmin,
    required this.location,
    required this.blog,
  });
}
