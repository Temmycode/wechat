import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/core/utils/contact_helper.dart';
import 'package:wechat/features/auth/models/user.dart';

class WeChatContactUsersNotifier extends AsyncNotifier<List<UserModel>> {
  final ApiClient _apiClient = ApiClient();

  Future<List<UserModel>> get allWeChatUsersonContactList async {
    try {
      final phoneNumbers = await ContactHelper.getContactPhoneNumbers();
      debugPrint('Phone numbers: $phoneNumbers');

      final response = await _apiClient.getAllContactsAsWechatUsers({
        'phone_numbers': phoneNumbers,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<UserModel> users =
            data.map((json) => UserModel.fromMap(json)).toList();

        return users;
      } else {
        debugPrint(response.data);
        return [];
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  Future<List<UserModel>> build() async {
    state = AsyncValue.loading();
    try {
      final users = await allWeChatUsersonContactList;
      state = AsyncValue.data(users);
      return users;
    } catch (err) {
      state = AsyncValue.error(err, StackTrace.current);
      return [];
    }
  }
}
