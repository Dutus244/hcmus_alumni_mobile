import 'package:hcmus_alumni_mobile/model/user.dart';

enum Status { loading, success }

class ChatCreateState {
  final String name;
  final String nameSearch;

  final Status status;
  final List<User> users;
  final int indexUser;
  final bool hasReachedMaxUser;
  final bool isLoading;

  const ChatCreateState({
    this.name = "",
    this.nameSearch = "",
    this.status = Status.loading,
    this.users = const [],
    this.indexUser = 0,
    this.hasReachedMaxUser = false,
    this.isLoading = false,
  });

  ChatCreateState copyWith({
    String? name,
    String? nameSearch,
    Status? status,
    List<User>? users,
    int? indexUser,
    bool? hasReachedMaxUser,
    bool? isLoading,
  }) {
    return ChatCreateState(
      name: name ?? this.name,
      nameSearch: nameSearch ?? this.nameSearch,
      status: status ?? this.status,
      users: users ?? this.users,
      indexUser: indexUser ?? this.indexUser,
      hasReachedMaxUser: hasReachedMaxUser ?? this.hasReachedMaxUser,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
