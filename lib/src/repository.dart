import 'package:dio/dio.dart';
import 'entities/asset.dart';
import 'entities/company.dart';
import 'entities/component.dart';
import 'entities/location.dart';

class Repository {
  Repository(this.http);

  final Dio http;

  static const apiUrl = 'https://fake-api.tractian.com';
  static const kCompanies = 'companies';
  static const kAssets = 'assets';
  static const kLocations = 'locations';

  Future<Set<Company>> fetchCompanies() async {
    final companies = <Company>{};

    final response = await http.get('$apiUrl/$kCompanies');
    for (var companyJson in response.data) {
      companies.add(Company.fromJson(companyJson));
    }
    assert(companies.length == response.data.length);

    // TODO: cache response
    return companies;
  }

  Future<Set<Location>> fetchLocations(Company company) async {
    final locations = <Location>{};

    final url = '$apiUrl/$kCompanies/${company.id}/$kLocations';
    final response = await http.get(url);
    for (var locationJson in response.data) {
      locations.add(Location.fromJson(locationJson));
    }
    assert(locations.length == response.data.length);

    // TODO: cache response
    return locations;
  }

  Future<Set<Asset>> fetchAssets(Company company) async {
    final assets = <Asset>{};

    final url = '$apiUrl/$kCompanies/${company.id}/$kAssets';
    final response = await http.get(url);
    for (var data in response.data) {
      if (data['sensorType'] != null) {
        assets.add(Component.fromJson(data));
      } else {
        assets.add(AssetContainer.fromJson(data));
      }
    }
    assert(assets.length == response.data.length);

    // TODO: cache response
    return assets;
  }
}
