import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import 'chat_widget.dart';
import 'package:http/http.dart' as http;

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({super.key});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextEditingController textController = TextEditingController();
  // Default tafsirId
  List<ChatMessage> messages = [];
  bool _isTyping = false;
  String savedText = '';
  bool _showListTafsirName = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: Center(
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    hintText: "إسال سؤالك...",
                    filled:
                    true, // This makes the background color fill the TextField
                    fillColor: Color(0xb2faeab1),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.primary,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: () async {
                setState(() {
                  savedText = textController.text;
                });
                await sendMessage(textController.text, 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage(String text, int tafsirId) async {
    textController.clear();

    // Add user message to the chat
    messages.add(ChatMessage(
      text: text,
      isUserMessage: true,
    ));
    setState(() {
      _isTyping = true;
      _showListTafsirName = false;
    });
    // Fetch response from the API
    final response = await http.get(
      Uri.parse(
          'https://wrd-bot-api.azurewebsites.net/api/v1/tafsir/$tafsirId/$text'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final suraName = jsonResponse['sura_name'] as String;
      final ayahNumber = jsonResponse['ayah_number'];
      final clear = jsonResponse['text'] as String;
      final tafsirName = jsonResponse['tafsir']['tafseer_name'] as String;
      final tafsirText = jsonResponse['tafsir']['text'] as String;

      // Add bot responses to the chat
      messages.add(ChatMessage(
        suraName: suraName,
        ayahNumber: ayahNumber,
        clear: clear,
        tafsirName: tafsirName,
        tafsirText: tafsirText,
        isUserMessage: false,
      ));
    } else {
      messages.add(const ChatMessage(
        isUserMessage: false,
        text:
        '"لا يوجد تفسير لهذه الآية. يرجى التحقق من الآية أو المحاولة مرة أخرى في وقت لاحق.',
      ));
    }

    // Update the UI
    setState(() {
      _isTyping = false;
      _showListTafsirName = true;
    });
  }
}
