import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_users/ui/user_provider.dart';
import 'package:go_router/go_router.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListState = ref.watch(userListProvider).userList;

    return Scaffold(
      appBar: AppBar(title: const Text('Github Users')),
      body: userListState.when(
        data: (userList) {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image(
                          width: 40.0,
                          height: 40.0,
                          image: NetworkImage(userList[index].avatarUrl),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(userList[index].login),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: userList[index].siteAdmin == true
                            ? const Text(
                                'staff',
                                style: TextStyle(color: Colors.red),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  final userName = userList[index].login;
                  ref.read(userListProvider.notifier).getUserDetail(userName);
                  context.go('/$userName');
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Text(e.toString()),
      ),
    );
  }
}
