import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/constants.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/features/home/presentation/providers/navigation_index_provider.dart';
import 'package:wechat/features/home/presentation/widgets/navigation_bar_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationIndexProvider.sync(
        builder: (context, value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: Container(
        height: context.h(86),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -4),
              color: AppColors.grey600.withValues(alpha: 0.4),
              blurRadius: 40,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: List.generate(navBarIcons.length, (index) {
            final icon = navBarIcons[index];

            return navigationIndexProvider.sync(
              builder: (context, value, _) {
                return NavigationBarButton(
                  onPressed: () {
                    navigationIndexProvider.value = index;
                  },
                  child: icon.toSvg(
                    height: context.h(24),
                    width: context.h(24),
                    color:
                        value == index ? AppColors.blue800 : AppColors.grey500,
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
