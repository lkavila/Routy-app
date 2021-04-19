
import '../entities/user.dart';

abstract class UserReposiroty {
  
  Future<UserEntity> login();

  
}