import 'dart:convert';
import 'package:bus_tracking_users/core/class/statusrequest.dart';
import 'package:bus_tracking_users/core/functions/checkinternet.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    if (await checkInternet()) {
      var response = await http.post(
        Uri.parse(linkurl),
        body: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        print("=======crud=$responsebody");
        print("=======crud=$response");

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> getData(
      String linkurl, Map<String, dynamic> params) async {
    if (await checkInternet()) {
      try {
        final uri = Uri.parse(linkurl).replace(queryParameters: params);

        final response = await http.get(uri);

        print("Response: ${response.body}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          final Map<String, dynamic> responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } catch (e) {
        print("Exception: $e");
        return const Left(StatusRequest.failure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
