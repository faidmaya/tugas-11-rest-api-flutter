import 'package:dio/dio.dart';
import '../model/user_model.dart';

class UserService {
  Dio dio = Dio();

  static const String baseUrl = 'https://reqres.in/api/users';

  // ===============================
  // GET LIST USER
  // ===============================
  Future<List<UserModel>> fetchUser() async {
    final response = await dio.get('$baseUrl?page=2');
    final data = response.data['data'];

    return List<UserModel>.from(
      data.map((user) => UserModel.fromJson(user)),
    );
  }

  // ===============================
  // GET DETAIL USER
  // ===============================
  Future<UserModel> fetchUserDetail(int id) async {
    final response = await dio.get('$baseUrl/$id');

    if (response.statusCode == 200) {
      final data = response.data['data'];
      return UserModel.fromJson(data);
    } else {
      throw Exception('Gagal mengambil detail user');
    }
  }
}
