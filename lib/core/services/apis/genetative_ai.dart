import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:qubic_ai/core/utils/constants/env.dart';

class GenerativeAIWebService {
  final _model = GenerativeModel(
    model: EnvManager.model,
    apiKey: EnvManager.apiKey,
  );
  Future<String?> postData(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      log("Data posted successfully!");

      final cleanResponse = response.text!.trim();
      log('response: $cleanResponse');
      return cleanResponse;
    } on Exception catch (err) {
      log(err.toString());
      return null;
    }
  }

  Stream<String?> streamData(String prompt) async* {
    try {
      final content = [Content.text(prompt)];
      final response = _model.generateContentStream(content);
      await for (final chunk in response) {
        yield chunk.text;
      }
    } on GenerativeAIException catch (e) {
      log(e.toString());
    }
  }
}
