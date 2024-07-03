import 'package:dio/dio.dart';
import 'entities/company.dart';
import 'entities/location.dart';

class Repository {
  Repository(this.http);

  final Dio http;

  static const apiUrl = 'https://fake-api.tractian.com';
  static const kCompanies = 'companies';
  static const kAssets = 'assets';
  static const kLocations = 'locations';

  Future<List<Company>> fetchCompanies() async {
    final companies = <Company>[];

    final response = await http.get('$apiUrl/$kCompanies');
    for (var companyJson in response.data) {
      companies.add(Company.fromJson(companyJson));
    }

    // TODO: cache response
    return companies;
  }

  Future<List<Location>> fetchLocations(Company company) async {
    final locations = <Location>[];

    final url = '$apiUrl/$kCompanies/${company.id}/$kLocations';
    final response = await http.get(url);
    for (var locationJson in response.data) {
      locations.add(Location.fromJson(locationJson));
    }

    // TODO: cache response
    return locations;
  }
}
