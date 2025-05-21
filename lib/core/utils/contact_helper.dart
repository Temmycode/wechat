import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as conts;
import 'package:wechat/core/utils/formatter.dart';

class ContactHelper {
  static Future<List<String>> getContactPhoneNumbers() async {
    if (await conts.FlutterContacts.requestPermission()) {
      Iterable<Contact> contacts = await ContactsService.getContacts();

      List<String> phoneNumbers = [];

      for (var contact in contacts) {
        if (contact.phones != null && contact.phones!.isNotEmpty) {
          // Get the raw phone number
          String rawNumber = contact.phones!.first.value ?? "";

          // Clean and standardize the phone number format
          String phoneNumber = await NumberFormatter.standardizePhoneNumber(
            rawNumber,
          );

          if (phoneNumber.isNotEmpty) {
            phoneNumbers.add(phoneNumber);
          }
        }
      }

      return phoneNumbers;
    } else {
      throw Exception("Contact permission denied");
    }
  }
}
