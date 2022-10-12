import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_users/ui/page/user_detail_page.dart';
import 'package:github_users/ui/page/user_list_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const UserListPage();
      },
    ),
    GoRoute(
      path: '/:userName',
      builder: (BuildContext context, GoRouterState state) {
        return UserDetailPage(userName: state.params['userName']!);
      },
    ),
  ],
);
