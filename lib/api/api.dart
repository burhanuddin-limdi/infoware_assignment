import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:infoware_assignment/environment/environment.dart';

const categories = [
  {'name': 'Top Rated Movies', 'path': 'movie/top_rated?', 'type': 'movie'},
  {'name': 'Top Rated Shows', 'path': 'tv/top_rated?', 'type': 'tv'},
  {'name': 'Trending Movies', 'path': 'movie/popular?', 'type': 'movie'},
  {'name': 'Trending Shows', 'path': 'tv/popular?', 'type': 'tv'},
  {'name': 'Coming Soon', 'path': 'movie/upcoming?', 'type': 'movie'},
  {'name': 'Shows Airing', 'path': 'tv/on_the_air?', 'type': 'tv'},
];

Future<dynamic> getData(dynamic category) async {
  var url = Uri.parse(
      '${environment['apiHost']}${category['path']}${environment['api_key']}&page=1&adult=true');
  var response = await http.get(url);
  return jsonDecode(response.body);
}

Future<dynamic> getSimilar(dynamic data, String? type) async {
  var url = Uri.parse(
      '${environment['apiHost']}$type/${data['id']}/similar?${environment['api_key']}&page=1&adult=true');
  var response = await http.get(url);
  return jsonDecode(response.body);
}
