import 'package:http/http.dart' as http;
class SMSApi {
  static const String apiKey = 'mpV9cRoElgHArjGw';
  static const String apiUrl =
      'http://adwingssms.com/sms/V1/send-sms-api.php';

  static Future<Map<String, dynamic>> sendSMS({
    required String senderId,
    required String templateId,
    required String entityId,
    required List<String> numbers,
    required String message,
  }) async {
    try {
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Cache-Control': 'no-cache',
      }, body: {
        'apikey': apiKey,
        'senderid': senderId,
        'templateid': templateId,
        'entityid': entityId,
        'number': numbers.join(','),
        'message': Uri.encodeComponent(message),
        'format': 'json',
      });

      if (response.statusCode == 200) {
        final responseData = response.body;
        // Parse and return the response data
        // You can return a Map with 'success' status and 'message'
        return {'success': true, 'message': 'SMS sent successfully'};
      } else {
        // Return error status with appropriate message
        return {'success': false, 'message': 'Failed to send SMS'};
      }
    } catch (e) {
      // Handle exception and return error status
      return {'success': false, 'message': 'An error occurred'};
    }
  }
}

