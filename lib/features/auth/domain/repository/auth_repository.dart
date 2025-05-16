import 'package:wechat/core/resources/data_state.dart';

abstract class AuthRepository {
  Future<DataState<void>> login();
  Future<DataState<void>> register();
}
