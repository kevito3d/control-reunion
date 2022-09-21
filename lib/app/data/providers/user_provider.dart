import 'package:control_reunion/app/data/models/user_model.dart';
import 'package:control_reunion/app/helper.dart';
import 'package:get/get.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.defaultDecoder = (map) {
    //   if (map["data"] is Map<String, dynamic>) return User.fromJson(map["data"]);
    //   if (map["data"] is List) {
    //     return map["data"].map((item) => User.fromJson(item)).toList();
    //   }
    // };     
    httpClient.baseUrl = baseurl;
  }

  //login
  Future<User> login({required String user, required String password, required String tokenPush}) async {
    print("lo que me esta llegando al provider:$user: $password");

    // create body for send request
    final body = {
      "correo": user,
      "password": password,
      "tokenPush": tokenPush
    };

    final response = await post("user/login", body);
    if (response.body['ok']) {
      // final token = response.body['token'];
      // httpClient.addRequestModifier<dynamic>((request) {
      //   request.headers['x-acces-token'] = token;
      //   return request;
      // });
      //modifi request to add query params
      return User.fromJson(response.body['data']);
    } else {
      return User(token: response.body['observacion']);
    }
  }

  Future<User?> getUser(int id) async {
    final response = await get('user/$id');
    return response.body;
  }

  Future<Response<User>> postUser(User user) async => await post('user', user);
  Future<Response> deleteUser(int id) async => await delete('user/$id');
}
