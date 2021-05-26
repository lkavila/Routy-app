import 'package:routy_app_v102/Data/repositories/user_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

mixin SendNotificationFinishUseCase{
  call();
}

class SendNotificationFinish implements SendNotificationFinishUseCase{
  final UserRepository _routeRepository =  UserRepositoryImpl();
  @override
  call() {
    return  _routeRepository.sendNotificationFinishRoute();
  }
}