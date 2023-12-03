import "package:learning_bloc/main.dart";
import "package:learning_bloc/models/user_model.dart";

class RestAPIService {
  Future<Map<String, dynamic>> addUserService(
      String email, String username) async {
    try {
      final Map<String, dynamic> map = {"username": username, "email": email};
      // http.Response response = await http.post(Uri.parse(""));
      await Future.delayed(const Duration(milliseconds: 500));
      bd.add(map);
      return map;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<UserModel>> readUserService() async {
    try {
      return bd.map((data) => UserModel.fromJson(data)).toList();
    } catch (err) {
      throw Exception(err);
    }
  }
}
