import 'package:flutter/material.dart';
import 'package:wechat/core/utils/size_config.dart';

class PasswordRecoveryOptionBox extends StatefulWidget {
  final bool isActive;
  final Color backgroundColor;
  final Color foregroundColor;
  final String text;
  final VoidCallback onTap;

  const PasswordRecoveryOptionBox({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<PasswordRecoveryOptionBox> createState() =>
      _PasswordRecoveryOptionBoxState();
}

class _PasswordRecoveryOptionBoxState extends State<PasswordRecoveryOptionBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.w(10)),
        height: context.h(40),
        width: context.w(199),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.r(18)),
          color: widget.backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              widget.text,
              style: TextStyle(
                fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w500,
                fontSize: 15,
                color: widget.isActive ? widget.foregroundColor : Colors.black,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: context.h(26),
              width: context.h(26),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.r(26)),
                color: widget.foregroundColor,
                border: Border.all(width: 2, color: Colors.white),
              ),
              child: widget.isActive
                  ? Icon(
                      Icons.check,
                      weight: 0.1,
                      size: context.sp(14),
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
