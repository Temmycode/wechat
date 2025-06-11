import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/formatter.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/chat/models/message.dart';
import 'package:wechat/features/chat/widgets/chat_block.dart';

class MessageByDateView extends StatelessWidget {
  final List<MessageModel> messages;

  const MessageByDateView({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    // convert the list of messages into {'date' : [...list of the messages for that day]}
    Map<DateTime, List<MessageModel>> messagesByDateMap = {};
    // add the messages into the map
    for (var message in messages) {
      final currentMessagesDate = message.timestamp;

      // get the key for the message which has the same date as this current entry
      DateTime? existingDateKey;
      for (DateTime key in messagesByDateMap.keys) {
        if (key.day == currentMessagesDate.day &&
            key.month == currentMessagesDate.month &&
            key.year == currentMessagesDate.year) {
          existingDateKey = key;
          break;
        }
      }

      if (existingDateKey != null) {
        // add the message to the map if the messages doesn't exist in the map key - values
        if (!messagesByDateMap[existingDateKey]!.contains(message)) {
          messagesByDateMap[existingDateKey]!.add(message);
        }
      } else {
        // create the key for that date and add all it's messages there
        messagesByDateMap[currentMessagesDate] = [message];
      }
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: context.h(150)),
      itemCount: messagesByDateMap.keys.length,
      itemBuilder: (context, index) {
        final dateKey = messagesByDateMap.keys.elementAt(index);
        final formattedDateForKey = DateFormatter.formatCustom(
          date: dateKey,
          useTodayText: true,
          yesterdayText: "Yesterday",
          otherDaysPattern: "MMM, dd",
        );
        // get the messages for this particular key in the - MAP
        final messageForKey = messagesByDateMap[dateKey];

        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: context.h(15)),
              padding: EdgeInsets.symmetric(
                horizontal: context.w(10),
                vertical: context.h(2),
              ),
              decoration: BoxDecoration(
                color: AppColors.blue200,
                borderRadius: BorderRadius.circular(context.r(8)),
              ),
              child: AppText(formattedDateForKey),
            ),

            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                top: context.h(23),
                left: context.w(16),
                right: context.w(16),
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: messageForKey?.length,
              itemBuilder: (context, index) {
                final message = messageForKey![index];

                return ChatBlock(message: message);
              },
            ),
          ],
        );
      },
    );
  }
}
