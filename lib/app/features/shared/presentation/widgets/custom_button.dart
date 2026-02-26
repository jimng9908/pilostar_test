import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/core/core.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final String text;
  final IconData? icon;
  final Color textColor;
  final bool? isLoading;
  final double? width;

  const CustomButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    required this.text,
    this.icon,
    required this.textColor,
    this.isLoading,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    // If the button is not clickable (loading or null onPressed), it is disabled
    final bool isClickable = isLoading != true && onPressed != null;

    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isClickable ? onPressed : null,
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: backgroundColor ?? AppColor.primary,
          disabledBackgroundColor: AppColor.primaryLight.withValues(alpha: 0.3),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: isLoading == true
            ? SizedBox(
                height: 20,
                width: 20,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  if (icon != null)
                    Icon(
                      icon,
                      color: isClickable ? textColor : AppColor.white,
                    ),
                  Text(
                    text,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isClickable ? textColor : AppColor.white,
                      fontSize:
                          icon != null ? 9.0.sp(context) : 12.0.sp(context),
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
