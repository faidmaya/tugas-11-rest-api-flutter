import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../service/user_service.dart';

class UserDetailPage extends StatefulWidget {
  final int userId;

  const UserDetailPage({super.key, required this.userId});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  Future<void> getDetail() async {
    user = await UserService().fetchUserDetail(widget.userId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user!.avatar),
            ),
            const SizedBox(height: 16),
            Text(
              '${user!.firstName} ${user!.lastName}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(user!.email),
          ],
        ),
      ),
    );
  }
}
