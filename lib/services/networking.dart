import 'dart:convert';

import 'package:clima/glitches/Glitch.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String endpoint;

  NetworkHelper(this.endpoint);

  Future<Either<Glitch, Map<String, dynamic>>> getData() async {
    http.Response response = await http.get(endpoint);
    if (response.statusCode == 200) {
      return Right(jsonDecode(response.body));
    } else {
      return Left(Glitch(
        title: "Network error",
        description: "A network error has occured. check you mobile connection",
      ));
    }
  }
}
