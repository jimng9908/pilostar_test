import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart'; // or failure

abstract class MyBusinessRemoteDataSource {
  Future<List<BusinessInformationModel>> getBusinessInfo(
      String placeUrl, String accessToken);
  Future<OrganizationModel> createOrganization(
      String name, String nif, String accessToken);
  Future<CompanyModel> createCompany(
      RequestCompanyModel requestCompanyModel, String accessToken);
  Future<ResponseVenueModel> createVenue(
      RequestVenueModel requestVenueModel, String accessToken);
  Future<List<DatasourceResponseModel>> connectDataSources(
      List<DatasourceRequestModel> datasourceRequestModels, String accessToken);
  Future<ResponseAutoConfigModel> startAutomaticConfiguration(
      RequestAutoConfigModel requestAutoConfigModel, String accessToken);
  Future<List<KpiModel>> getKpiListByUserId(String accessToken, int userId);
  Future<List<ResponseKpiPreferencesModel>> submitKpiPreferences(
      String accessToken, List<RequestKpiPreferencesModel> kpiModels);
  Future<ResponseGoalModel> submitGoals(
      String accessToken, RequestGoalsModel goals);
}

class MyBusinessRemoteDataSourceImpl implements MyBusinessRemoteDataSource {
  MyBusinessRemoteDataSourceImpl();

  @override
  Future<List<BusinessInformationModel>> getBusinessInfo(
      String placeUrl, String accessToken) async {
    try {
      final String fullUrl =
          '${Constants.baseAuthUrl}/google-places/search?query=${Uri.encodeComponent(placeUrl)}';

      final response = await http.get(
        Uri.parse(fullUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        final List infoJson = jsonDecode(response.body) as List;
        return infoJson
            .map<BusinessInformationModel>(
                (e) => BusinessInformationModel.fromJson(e))
            .toList();
      }
      if (response.statusCode == 400) {
        throw ServerException(message: 'Datos de organización inválidos');
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      }
      if (response.statusCode == 403) {
        throw ServerException(message: 'Rol de Admin o SuperAdmin requerido');
      } else {
        throw ServerException(message: 'Error buscando el negocio');
      }
    } on ServiceException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrganizationModel> createOrganization(
      String name, String nif, String accessToken) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/organizations/onboarding'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(
          {
            "name": name,
            "nif": nif,
          },
        ),
      );
      if (response.statusCode == 201) {
        return OrganizationModel.fromJson(jsonDecode(response.body));
      }
      if (response.statusCode == 400) {
        throw ServerException(message: 'Datos de organización inválidos');
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      }
      if (response.statusCode == 403) {
        throw ServerException(message: 'Rol de Admin o SuperAdmin requerido');
      } else {
        throw GenericException(message: 'Error creando la organización');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CompanyModel> createCompany(
      RequestCompanyModel requestCompanyModel, String accessToken) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/companies/onboarding'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(
          {
            "name": requestCompanyModel.name,
            "address": requestCompanyModel.address,
            "phone": requestCompanyModel.phone,
            "email": requestCompanyModel.email,
            "website": requestCompanyModel.website,
            "organizationId": requestCompanyModel.organizationId,
          },
        ),
      );
      if (response.statusCode == 201) {
        return CompanyModel.fromJson(jsonDecode(response.body));
      }
      if (response.statusCode == 400) {
        throw ServerException(message: 'Datos de compañía inválidos');
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error creando la compañía');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseVenueModel> createVenue(
      RequestVenueModel requestVenueModel, String accessToken) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/venue/onboarding'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(requestVenueModel.toJson()),
      );

      if (response.statusCode == 201) {
        return ResponseVenueModel.fromJson(jsonDecode(response.body));
      }
      if (response.statusCode == 400) {
        throw ServerException(message: 'Datos de venue inválidos');
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error creando el local');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DatasourceResponseModel>> connectDataSources(
      List<DatasourceRequestModel> datasourceRequestModels,
      String accessToken) async {
    try {
      final body =
          jsonEncode(datasourceRequestModels.map((e) => e.toJson()).toList());

      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/data-sources/select'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        final List<dynamic> decoded = jsonDecode(response.body);
        return decoded
            .map((json) => DatasourceResponseModel.fromJson(json))
            .toList();
      }
      if (response.statusCode == 400) {
        throw ServerException(message: 'Datos de datasource inválidos');
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error conectando fuentes de datos');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseAutoConfigModel> startAutomaticConfiguration(
      RequestAutoConfigModel requestAutoConfigModel, String accessToken) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/venue/import-from-google'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(requestAutoConfigModel.toJson()),
      );

      if (response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        return ResponseAutoConfigModel.fromJson(decoded);
      }
      if (response.statusCode == 400) {
        throw ServerException(message: 'Datos inválidos');
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error configurando el negocio');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<KpiModel>> getKpiListByUserId(
      String accessToken, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/k-picore-finance/kpis/by-sources'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(
          {
            "userId": userId,
          },
        ),
      );

      if (response.statusCode == 201) {
        final decoded = jsonDecode(response.body) as List;
        return decoded.map((json) => KpiModel.fromJson(json)).toList();
      }
      if (response.statusCode == 400) {
        throw ServerException(message: 'Datos inválidos');
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error obteniendo los kpis');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ResponseKpiPreferencesModel>> submitKpiPreferences(
      String accessToken, List<RequestKpiPreferencesModel> kpiModels) async {
    try {
      final body = jsonEncode(kpiModels.map((e) => e.toJson()).toList());
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/users/kpi-preferences'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        final List<dynamic> decoded = jsonDecode(response.body);
        return decoded
            .map((json) => ResponseKpiPreferencesModel.fromJson(json))
            .toList();
      }
      if (response.statusCode == 400) {
        throw ServerException(message: 'Datos de datasource inválidos');
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error configurando Kpis');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseGoalModel> submitGoals(
      String accessToken, RequestGoalsModel goals) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseAuthUrl}/user-goals'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(goals.toJson()),
      );

      if (response.statusCode == 201) {
        return ResponseGoalModel.fromJson(jsonDecode(response.body));
      }
      if (response.statusCode == 400) {
        throw ServerException(message: 'Datos de datasource inválidos');
      }
      if (response.statusCode == 401) {
        throw ServerException(message: 'No autenticado');
      } else {
        throw GenericException(message: 'Error conectando datasource');
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
