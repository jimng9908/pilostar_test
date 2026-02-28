import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/home/data/models/test_data_model.dart';
import 'package:rockstardata_apk/app/features/home/index.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio; // ← Inyecta Dio en lugar de usar http.Client

  HomeRemoteDataSourceImpl({required this.dio});
  @override
  Future<MetricEntity?> getTotalRevenueAndExpenses(
      DashboardFilter filter) async {
    //TestDataModel para prueba, TODO: pedir por parametro
    TestDataModel params = TestDataModel.fromFilter(filter);
    final response = await http.get(
      Uri.parse(
              '${Constants.baseAuthUrl}/k-picore-finance/total-revenue-and-expenses')
          .replace(
        queryParameters: {
          'company_name': params.companyName,
          'venue_name': params.venueName,
          'start_date': params.startDate,
          'end_date': params.endDate,
          'compare': params.compare,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // La respuesta es una lista
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Verificar que no está vacía
      if (jsonList.isNotEmpty) {
        // Tomar el primer elemento (y único)
        final Map<String, dynamic> data =
            jsonList.first as Map<String, dynamic>;
        MetricEntity resp = MetricEntity.fromJsonTotalRevenueAndExpenses(data);
        return resp.title != '' ? resp : null;
      } else {
        //Lista vacia
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<MetricEntity?> getTotalRevenue(DashboardFilter filter) async {
    //TestDataModel para prueba, TODO: pedir por parametro
    TestDataModel params = TestDataModel.fromFilter(filter);
    final response = await http.get(
      Uri.parse('${Constants.baseAuthUrl}/k-picore-finance/total-revenue')
          .replace(
        queryParameters: {
          'company_name': params.companyName,
          'venue_name': params.venueName,
          'start_date': params.startDate,
          'end_date': params.endDate,
          'compare': params.compare,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // La respuesta es una lista
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Verificar que no está vacía
      if (jsonList.isNotEmpty) {
        // Tomar el primer elemento (y único)
        final Map<String, dynamic> data =
            jsonList.first as Map<String, dynamic>;
        MetricEntity resp = MetricEntity.fromJsonTotalRevenue(data);
        return resp.title != '' ? resp : null;
      } else {
        //Lista vacia
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<MetricEntity?> getCustomers(DashboardFilter filter) async {
    //TestDataModel para prueba, TODO: pedir por parametro
    TestDataModel params = TestDataModel.fromFilter(filter);
    final response = await http.get(
      Uri.parse('${Constants.baseAuthUrl}/k-picore-finance/customers').replace(
        queryParameters: {
          'company_name': params.companyName,
          'venue_name': params.venueName,
          'start_date': params.startDate,
          'end_date': params.endDate,
          'compare': params.compare,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // La respuesta es una lista
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Verificar que no está vacía
      if (jsonList.isNotEmpty) {
        // Tomar el primer elemento (y único)
        final Map<String, dynamic> data =
            jsonList.first as Map<String, dynamic>;
        MetricEntity resp = MetricEntity.fromJsonCustomers(data);
        return resp.title != '' ? resp : null;
      } else {
        //Lista vacia
        return null;
      }
    } else {
      return null;
    }
  }

  @override
//revisar que da error 500
  Future<MetricEntity?> getAverageTicket(DashboardFilter filter) async {
    //TestDataModel para prueba, TODO: pedir por parametro
    TestDataModel params = TestDataModel.fromFilter(filter);
    final response = await http.get(
      Uri.parse('${Constants.baseAuthUrl}/k-picore-finance/ticket-medium')
          .replace(
        queryParameters: {
          'company_name': params.companyName,
          'venue_name': params.venueName,
          'start_date': params.startDate,
          'end_date': params.endDate,
          'compare': params.compare,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // La respuesta es una lista
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Verificar que no está vacía
      if (jsonList.isNotEmpty) {
        // Tomar el primer elemento (y único)
        final Map<String, dynamic> data =
            jsonList.first as Map<String, dynamic>;
        MetricEntity resp = MetricEntity.fromJsonAverageTicket(data);
        return resp.title != '' ? resp : null;
      } else {
        //Lista vacia
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<MetricEntity?> getPersonalPercentage(DashboardFilter filter) async {
    //TestDataModel para prueba, TODO: pedir por parametro
    TestDataModel params = TestDataModel.fromFilter(filter);
    final response = await http.get(
      Uri.parse('${Constants.baseAuthUrl}/k-picore-finance/personal-percentage')
          .replace(
        queryParameters: {
          'company_name': params.companyName,
          'venue_name': params.venueName,
          'start_date': params.startDate,
          'end_date': params.endDate,
          'compare': params.compare,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // La respuesta es una lista
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Verificar que no está vacía
      if (jsonList.isNotEmpty) {
        // Tomar el primer elemento (y único)
        final Map<String, dynamic> data =
            jsonList.first as Map<String, dynamic>;
        MetricEntity resp = MetricEntity.fromJsonPersonalPercentage(data);
        return resp.title != '' ? resp : null;
      } else {
        //Lista vacia
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<MetricEntity?> getMerchandisePercentage(DashboardFilter filter) async {
    //TestDataModel para prueba, TODO: pedir por parametro
    TestDataModel params = TestDataModel.fromFilter(filter);
    final response = await http.get(
      Uri.parse(
              '${Constants.baseAuthUrl}/k-picore-finance/merchandise-percentage')
          .replace(
        queryParameters: {
          'company_name': params.companyName,
          'venue_name': params.venueName,
          'start_date': params.startDate,
          'end_date': params.endDate,
          'compare': params.compare,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // La respuesta es una lista
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Verificar que no está vacía
      if (jsonList.isNotEmpty) {
        // Tomar el primer elemento (y único)
        final Map<String, dynamic> data =
            jsonList.first as Map<String, dynamic>;
        MetricEntity resp = MetricEntity.fromJsonMerchandisePercentage(data);
        return resp.title != '' ? resp : null;
      } else {
        //Lista vacia
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<MetricEntity?> getProfitability(DashboardFilter filter) async {
    //TestDataModel para prueba, TODO: pedir por parametro
    TestDataModel params = TestDataModel.fromFilter(filter);
    final response = await http.get(
      Uri.parse('${Constants.baseAuthUrl}/k-picore-finance/profitability')
          .replace(
        queryParameters: {
          'company_name': params.companyName,
          'venue_name': params.venueName,
          'start_date': params.startDate,
          'end_date': params.endDate,
          'compare': params.compare,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // La respuesta es una lista
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Verificar que no está vacía
      if (jsonList.isNotEmpty) {
        // Tomar el primer elemento (y único)
        final Map<String, dynamic> data =
            jsonList.first as Map<String, dynamic>;
        MetricEntity resp = MetricEntity.fromJsonProfitability(data);
        return resp.title != '' ? resp : null;
      } else {
        //Lista vacia
        return null;
      }
    } else {
      return null;
    }
  }
}
