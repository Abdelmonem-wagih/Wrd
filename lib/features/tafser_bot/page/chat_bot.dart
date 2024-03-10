import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/core/utils/app_constance.dart';
import '../../../../core/utils/app_string.dart';
import 'package:provider/provider.dart';

import '../widget/chat_widget.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  TextEditingController textController = TextEditingController();

  FocusNode focusNode = FocusNode();
  //final settings = AppSettings(); // Access the singleton instance

  List<ChatMessage> messages = [];
  bool _isTyping = false;
  bool readOnly = false;
  bool _isChange = true;
  String savedText = '';
  bool _showListTafsirName = false;
  int _selectitem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: const Image(
                image: AssetImage('assets/image/helf_down_frame.png'),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.8),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.primary,
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                if (messages.isEmpty) ...[
                  SvgPicture.asset(
                    'assets/svg/icon_group.svg',
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ],
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return messages[index];
                    },
                  ),
                ),
                if (_isTyping) ...[
                  const SpinKitThreeBounce(
                    color: AppColors.primary,
                    size: 18,
                  ),
                ],
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _isChange == true
                      ? Consumer<AppSettings>(builder: (context, settings, _) {
                          return settings.isReadOnly == true
                              ? Container()
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(
                                          child: TextField(
                                            minLines: 1,
                                            maxLines: 10,
                                            readOnly: settings.isReadOnly,
                                            focusNode: focusNode,
                                            controller: textController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              hintText: "أدخل الآية...",
                                              filled: true,
                                              fillColor: Color(0xb2faeab1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.width),
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color: AppColors.primary,
                                      ),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ),
                                        onPressed: () async {
                                          if (messages.isNotEmpty) {
                                            messages.removeRange(
                                              messages.length - 2,
                                              messages.length,
                                            );
                                          }
                                          await checkMessage(
                                            textController.text,
                                            8,
                                          );

                                          // if (await checkMessage(
                                          //         textController.text,
                                          //         _selectitem + 1) ==
                                          //     true) {
                                          //   setState(() {
                                          //     _isChange = false;
                                          //     _showListTafsirName = true;
                                          //     if (messages.isNotEmpty) {
                                          //       messages.removeRange(
                                          //         messages.length - 2,
                                          //         messages.length,
                                          //       );
                                          //     }
                                          //   });
                                          // }
                                          // await sendMessage(textController.text, 1);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                        })
                      : Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: 50,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: AppColors.brown,
                                ),
                                child: Center(
                                  child: Text(
                                    tafsirNameList[_selectitem],
                                    style: const TextStyle(
                                      color: AppColors.baseWhite,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Almarai",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: AppColors.brown,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      _isChange = true;
                                      savedText = textController.text;
                                      _showListTafsirName = false;
                                    });
                                    await checkMessage(
                                      textController.text,
                                      _selectitem + 1,
                                    );


                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
            Positioned(
              height: 400,
              right: 10,
              width: 170,
              bottom: 150,
              child: Visibility(
                visible: _showListTafsirName,
                child: Container(
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: tafsirNameList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          setState(() {
                            _selectitem = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: 250,
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            color: _selectitem == index
                                ? AppColors.brown
                                : AppColors.second,
                          ),
                          child: Center(
                            child: Text(
                              tafsirNameList[index],
                              style: const TextStyle(
                                  color: AppColors.baseWhite,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Almarai",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.0),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkMessage(String text, int tafsirId) async {
    if (text.isEmpty) {
      return;
    }


    // Add user message to the chat
    setState(() {
      readOnly = true;
      _isTyping = true;
      focusNode.unfocus();
    });
    var settings = Provider.of<AppSettings>(context, listen: false);
    settings.setReadOnly(!settings.isReadOnly);
    debugPrint('from Chat Bot=>>>>>>>>>>>>>>>>>>>>>>> ${settings.isReadOnly}');

    // Fetch response from the API
    final response = await http.get(
      Uri.parse('${AppConstance.checkTafsirBot}$text'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final suraNumber = jsonResponse['sura_number'];
      final ayahNumber = jsonResponse['aya_number'];
      // Add bot responses to the chat
      debugPrint('sendMessage=>>>>>>>>>>>>>>>>>>>>>>> sendMessage true');

      if (tafsirId == 8) {
        _isChange = false;
        _showListTafsirName = true;
        messages.add(ChatMessage(
          text: text,
          isUserMessage: true,
        ));
      } else {
        await sendMessage(
          ayaNumber: ayahNumber,
          suraNumber: suraNumber,
          tafsirId: tafsirId,
          text: text,
        );
      }
    } else {
      textController.clear();

      debugPrint('sendMessage=>>>>>>>>>>>>>>>>>>>>>>> sendMessage false');
      messages.add(ChatMessage(
        text: text,
        isUserMessage: true,
      ));

      messages.add(
        const ChatMessage(
          isUserMessage: false,
          text: AppString.errorTafsir,
        ),
      );
    }
    setState(() {
      _isTyping = false;
    });
  }

  Future<void> sendMessage({
    required int suraNumber,
    required int ayaNumber,
    required int tafsirId,
    required String text,
  }) async {
    debugPrint('sendMessage user========================================================');

    textController.clear();
    setState(() {
      // readOnly = true;
      focusNode.unfocus();
    });
    var settings = Provider.of<AppSettings>(context, listen: false);
    settings.setReadOnly(!settings.isReadOnly);
    debugPrint('from Chat Bot=>>>>>>>>>>>>>>>>>>>>>>> ${settings.isReadOnly}');

    // Fetch response from the API
    final response = await http.get(
      Uri.parse('${AppConstance.tafsirBot}$tafsirId/$ayaNumber/$suraNumber'),
    );

    if (response.statusCode == 200) {
      debugPrint('sendMessage user seucsse========================================================');

      final jsonResponse = json.decode(response.body);
      final suraName = jsonResponse['name'];
      final ayahNumber = jsonResponse['ayaid'];
      final clear = jsonResponse['text'] as String;
      final tafsirName = jsonResponse['tafsir']['tafseer_name'] as String;
      final tafsirText = jsonResponse['tafsir']['text'] as String;

      // Add bot responses to the chat
      messages.add(
        ChatMessage(
          suraName: suraName,
          ayahNumber: ayahNumber,
          clear: clear,
          tafsirName: tafsirName,
          tafsirText: tafsirText,
          isUserMessage: false,
          tafsirReader: tafsirNameList[tafsirId - 1],
        ),
      );
    }else{
      debugPrint('sendMessage user feild========================================================');

    }

    // Update the UI
    setState(() {
      _isTyping = false;
    });
  }
}
