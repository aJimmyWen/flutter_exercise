import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_users/data/model/user_model.dart';
import 'package:github_users/data/repository/user_repository.dart';

class UserState {
  final AsyncValue<UserDetail> currentUser;
  late final AsyncValue<List<User>> userList;

  UserState({
    this.currentUser = const AsyncValue.loading(),
    this.userList = const AsyncValue.loading(),
  });

  UserState updateState({List<User>? userList, UserDetail? currentUser}) {
    return UserState(
      userList: userList != null ? AsyncValue.data(userList) : this.userList,
      currentUser:
          currentUser != null ? AsyncValue.data(currentUser) : this.currentUser,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this._userRepository) : super(UserState());

  final UserRepository _userRepository;

  Future<void> fetchUsers() async {
    try {
      final userList = await _userRepository.fetchUsers();
      state = state.updateState(userList: userList);
    } catch (err) {
      // ignore: avoid_print
      print('error $err');
    }
  }

  Future<void> getUserDetail(String userName) async {
    try {
      final userDetail = await _userRepository.getUser(userName);
      state = state.updateState(currentUser: userDetail);
    } catch (err) {
      // ignore: avoid_print
      print('error $err');
    }
  }
}

final userListProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final userNotifier = UserNotifier(ref.watch(userRepositoryProvider));
  userNotifier.fetchUsers();
  return userNotifier;
});
