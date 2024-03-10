import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wrd/core/utils/app_colors.dart';

import '../../../../core/utils/app_constance.dart';
import '../controller/fade_rout.dart';
import 'chat_bot.dart';

class SplashBotScreen extends StatelessWidget {
  const SplashBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.8),
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
          SvgPicture.asset(
            'assets/svg/icon_bot.svg',
            // height: MediaQuery.of(context).size.height * 0.2,
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              FadeRoute(
                ChangeNotifierProvider(
                    create: (BuildContext context) => AppSettings(),
                    child: const ChatBotScreen()),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(60),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.lightYellow,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Center(
                child: Text(
                  'فسر الآن',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Almarai",
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0),
                ),
              ),
            ),
          ),
          Image.asset('assets/image/helf_down_frame.png')
        ],
      ),
    );
  }
}
