import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_constance.dart';

import '../../../../core/utils/app_colors.dart';

class ChatMessage extends StatefulWidget {
  final String? suraName;
  final int? ayahNumber;
  final String? clear;
  final String? tafsirName;
  final String? tafsirText;
  final String? tafsirReader;
  final bool isUserMessage;

  const ChatMessage({
    this.suraName,
    this.ayahNumber,
    this.clear,
    this.tafsirName,
    this.tafsirText,
    this.tafsirReader,
    required this.isUserMessage,
    Key? key,
    this.text,
  }) : super(key: key);

  final String? text;

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  bool showSecondContainer = false;
  bool showthiredContainer = false;

  @override
  Widget build(BuildContext context) {
    final CrossAxisAlignment crossAxisAlignment = widget.isUserMessage
        ? CrossAxisAlignment.end // User's messages on the left
        : CrossAxisAlignment.start;
    return widget.isUserMessage == true
        ? Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              ContainerWidget(
                isUser: true,
                widget: widget,
                color: AppColors.primary,
              ),
            ],
          )
        : widget.suraName == null
            ? ContainerWidget(
                isUser: false,
                widget: widget,
                color: AppColors.lightYellow,
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: AppColors.lightYellow,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                            style: TextStyle(
                              color: AppColors.darkTone,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Almarai",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0.fontSize,
                              height: 1.5.height,
                            ),
                            child: AnimatedTextKit(
                              onFinished: () {
                                setState(() {
                                  showSecondContainer = true;
                                });
                              },
                              isRepeatingAnimation: false,
                              repeatForever: false,
                              displayFullTextOnTap: true,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(
                                  ('${widget.clear} (${widget.ayahNumber})')
                                      .trim(),
                                ),
                              ],
                            ),
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                              color: AppColors.darkTone,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Almarai",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0.fontSize,
                              height: 1.5.height,
                            ),
                            child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              repeatForever: false,
                              displayFullTextOnTap: true,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(
                                  ('سورة  ${widget.suraName}').trim(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Visibility(
                      visible: showSecondContainer,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          color: AppColors.lightYellow,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(0),
                          ),
                        ),
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            height: 1.5,
                            color: AppColors.darkTone,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Almarai",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0,
                          ),
                          child: AnimatedTextKit(
                            onFinished: () {
                              setState(() {
                                showthiredContainer = true;
                              });
                            },
                            isRepeatingAnimation: false,
                            repeatForever: false,
                            displayFullTextOnTap: true,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText(
                                ('${widget.tafsirText}').trim(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Visibility(
                      visible: showthiredContainer,
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          color: AppColors.lightYellow,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(0),
                          ),
                        ),
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            height: 1.5,
                            color: AppColors.darkTone,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Almarai",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0,
                          ),
                          child: AnimatedTextKit(
                            onFinished: () {
                              var settings = Provider.of<AppSettings>(context,
                                  listen: false);
                              settings.setReadOnly(!settings.isReadOnly);
                            },
                            isRepeatingAnimation: false,
                            repeatForever: false,
                            displayFullTextOnTap: true,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText('${widget.tafsirReader}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required this.widget,
    required this.color,
    required this.isUser,
  });

  final ChatMessage widget;
  final Color color;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(0),
        ),
      ),
      child: isUser == true
          ? Text(
              '${widget.text}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "Almarai",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.left,
            )
          : DefaultTextStyle(
              style: const TextStyle(
                height: 1.5,
                color: AppColors.darkTone,
                fontWeight: FontWeight.w400,
                fontFamily: "Almarai",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
              child: AnimatedTextKit(
                onFinished: () {
                  var settings =
                      Provider.of<AppSettings>(context, listen: false);
                  settings.setReadOnly(!settings.isReadOnly);
                },
                isRepeatingAnimation: false,
                repeatForever: false,
                displayFullTextOnTap: true,
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText('${widget.text}'),
                ],
              ),
            ),
    );
  }
}
