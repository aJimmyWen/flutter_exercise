import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_users/ui/user_provider.dart';
import 'package:github_users/ui/widget/avatar.dart';
import 'package:go_router/go_router.dart';

class UserDetailPage extends ConsumerWidget {
  const UserDetailPage({required this.userName, Key? key}) : super(key: key);

  final String userName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetailState = ref.watch(userListProvider).currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.go('/'),
        ),
        elevation: 0,
      ),
      body: userDetailState.when(
        data: (userData) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),
              AvatarWidget(
                imagePath: userData.avatarUrl,
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Text(userData.login),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: [
                  Text(userData.name),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.pin_drop),
                  Text(userData.location),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: [
                  Text(userData.blog),
                ],
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Text(e.toString()),
      ),
    );
  }
}
