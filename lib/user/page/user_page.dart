import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../service/user_service.dart';
import 'user_detail_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    users = await UserService().fetchUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(users[index].avatar),
            title: Text(
              '${users[index].firstName} ${users[index].lastName}',
            ),
            subtitle: Text(users[index].email),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserDetailPage(
                    userId: users[index].id,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
