import 'package:dio/dio.dart';
import 'entities/company.dart';

class Repository {
  Repository(this.http);

  final Dio http;

  static const apiUrl = 'https://fake-api.tractian.com';
  static const kCompanies = 'companies';
  static const kAssets = 'assets';
  static const kLocations = 'locations';

  Future<List<Company>> fetchCompanies() async {
    final companies = <Company>[];

    final response = await http.get('$apiUrl/companies');
    for (var companyJson in response.data) {
      companies.add(Company.fromJson(companyJson));
    }

    // TODO: cache response
    return companies;
  }
}

// class RepositoryError implements Exception {
//   RepositoryError(this.error, this.message);
//
//   final Object error;
//   final String message;
// }
