

import 'package:routy_app_v102/Domain/entities/user.dart';

abstract class UserReposiroty {
  
  Future<UserEntity> login();
}