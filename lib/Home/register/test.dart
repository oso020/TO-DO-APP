import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonEncode

class Api {
  static Future<http.Response> postDataHttp({
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    // Define the URL
    final Uri url = Uri.https("ecommerce.routemisr.com", "/api/v1/auth/signup");

    // Encode the body as JSON
    final bodyJson = jsonEncode(body);

    // Set default headers if not provided
    final requestHeaders = headers ?? {
      'Content-Type': 'application/json',
    };

    try {
      // Send POST request
      final response = await http.post(
        url,
        body: bodyJson,
        headers: requestHeaders,
      );

      // Log the response for debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      return response;
    } catch (e) {
      // Handle errors
      print('Error: $e');
      rethrow; // Rethrow the exception for further handling
    }
  }
}
