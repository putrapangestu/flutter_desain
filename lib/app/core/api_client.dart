import 'package:dio/dio.dart';

class ApiClient {
   final Dio _dio = Dio();

    Future<Response> registerUser(Map<String, dynamic>? userData) async {
        try {
          Response response = await _dio.post(
              'http://acc.sugenghartono.ac.id/api/login',  //ENDPONT URL
              data: userData, //REQUEST BODY
              queryParameters: {'apikey': 'YOUR_API_KEY'},  //QUERY PARAMETERS
              options: Options(headers: {'X-LoginRadius-Sott': 'YOUR_SOTT_KEY', //HEADERS
          }));
          //returns the successful json object
          return response.data;
        } on DioException catch (e) {
          //returns the error object if there is
          return e.response!.data;
        }
    }

    Future<Response> login(String? email, String? password) async {
      try {
        Response response = await _dio.post(
          'http://libeltix.com/api/login',
          data: {
            'email': email,
            'password': password,
          },
        );
        return response;
      } on DioException catch (e) {
        return e.response!;
      }
    }

    Future<Response> scanner(String? code, String token) async {
      try {
        Response response = await _dio.post(
          'http://libeltix.com/api/checkin',
          data: {
            'code': code!,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token}', // Replace 'Token' with the actual token value
              'Accept': 'application/ecmascript',
            },
          ),
        );
        return response;
      } on DioException catch (e) {
        return e.response!;
      }
    }

    Future<Response> fetchScan(String token) async {
      try {
        Response response = await _dio.get(
          'http://libeltix.com/api/fetch-checked',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json'
            }
          )
        );
        return response;
      } on DioException catch (e) {
        return e.response!;
      }
    }

    Future<Response> getUserProfileData(String accessToken) async {
      try {
        Response response = await _dio.get(
          'https://api.loginradius.com/identity/v2/auth/account',
          queryParameters: {'apikey': 'YOUR_API_KEY'},
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );
        return response.data;
      } on DioException catch (e) {
        return e.response!.data;
      }
    }

    Future<Response> logout(String accessToken) async {
        try {
          Response response = await _dio.get(
            'https://api.loginradius.com/identity/v2/auth/access_token/InValidate',
            queryParameters: {'apikey': ''},
            options: Options(
              headers: {'Authorization': 'Bearer $accessToken'},
            ),
          );
          return response.data;
        } on DioException catch (e) {
          return e.response!.data;
        }
     }
}