import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

abstract class PaymentPlansDataSource {
  Future<List<PlanModel>> getPlans(String accessToken);
  Future<FreeTrialModel> getFreeTrial(String accessToken);
  Future<PaymentIntentModel> createPaymentIntent(
      String accessToken, int planId);
  Future<PaymentSubscriptionStatusModel> getPaymentSubscriptionStatus(
      String accessToken, String paymentIntentId);
  Future<SubscriptionStatusModel> getSubscriptionStatus(String accessToken);
}

class PaymentPlansDataSourceImpl implements PaymentPlansDataSource {
  @override
  Future<List<PlanModel>> getPlans(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseAuthUrl}/subscriptions/plans'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((x) => PlanModel.fromJson(x))
            .toList();
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error fetching plans');
      }
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }

  @override
  Future<PaymentIntentModel> createPaymentIntent(
      String accessToken, int planId) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/subscriptions/create-intent'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'planId': planId}),
      );
      if (response.statusCode == 201) {
        return PaymentIntentModel.fromJson(jsonDecode(response.body));
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error creating payment intent');
      }
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }

  @override
  Future<PaymentSubscriptionStatusModel> getPaymentSubscriptionStatus(
      String accessToken, String paymentIntentId) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Constants.baseAuthUrl}/subscriptions/check-payment-status/$paymentIntentId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PaymentSubscriptionStatusModel.fromJson(data);
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error checking subscription status');
      }
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }

  @override
  Future<FreeTrialModel> getFreeTrial(String accessToken) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/subscriptions/start-trial'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return FreeTrialModel.fromJson(data);
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error getting free trial');
      }
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }

  @override
  Future<SubscriptionStatusModel> getSubscriptionStatus(
      String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseAuthUrl}/subscriptions/status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SubscriptionStatusModel.fromJson(data);
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error getting subscription status');
      }
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }
}
