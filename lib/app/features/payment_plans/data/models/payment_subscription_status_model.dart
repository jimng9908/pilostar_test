import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class PaymentSubscriptionStatusModel extends PaymentSubscriptionStatusEntity {
  const PaymentSubscriptionStatusModel({
    required super.success,
    required super.status,
    required super.subscriptionId,
    required super.message,
  });

  factory PaymentSubscriptionStatusModel.fromJson(Map<String, dynamic> json) {
    return PaymentSubscriptionStatusModel(
      success: json['success'] ?? false,
      status: json['status'] ?? '',
      subscriptionId: json['subscriptionId'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status': status,
      'subscriptionId': subscriptionId,
      'message': message,
    };
  }
}
