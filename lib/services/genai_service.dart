import 'dart:convert';
import 'package:http/http.dart' as http;

class GenAIService {
  static const String apiKey = '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';
  static const String endpoint = 'https://api.openai.com/v1/chat/completions';

  static Future<String> getReply(String prompt, String persona) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "You are a $persona"},
          {"role": "user", "content": prompt}
        ],
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['choices'][0]['message']['content'].trim();
    } else {
      return "Sorry, I couldn't process your request.";
    }
  }
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ChatService {
//   static const apiKey = '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'; 

//   static Future<String> sendMessage(String message) async {
//     final url = Uri.parse("https://api.openai.com/v1/chat/completions");

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $apiKey',
//       },
//       body: jsonEncode({
//         "model": "gpt-3.5-turbo",
//         "messages": [
//           {"role": "user", "content": message}
//         ],
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data["choices"][0]["message"]["content"];
//     } else {
//       return "Sorry, failed to get response.";
//     }
//   }
// }


// // //AIzaSyCQuumck3TGl17KldpMjhFSzql2Q9uM_FY
// //AIzaSyC5HZaw08_XEoLedtuaKWKdoT5ycJ7oCcc 

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ChatService {
//   Future<String> sendMessage(String message) async {
//     const apiKey = 'AIzaSyC5HZaw08_XEoLedtuaKWKdoT5ycJ7oCcc '; // 🔁 Replace with your actual Gemini API key
//     final url =
//         'https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=$apiKey';

//     final response = await http.post(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         "contents": [
//           {
//             "parts": [
//               {"text": message}
//             ]
//           }
//         ]
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['candidates'][0]['content']['parts'][0]['text'];
//     } else {
//       return 'API Error: ${response.statusCode}\n${response.body}';
//     }
//   }
// }
