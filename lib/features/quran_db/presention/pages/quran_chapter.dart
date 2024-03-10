import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/core/widget/loading_widget.dart';
import 'package:wrd/features/quran_db/presention/pages/quran_db_screen.dart';
import 'package:wrd/main.dart';
import '../cubit/quran_chapter_cubit.dart';
import '../widget/quran_chapter_widget.dart';
import '../widget/surah_search.dart';

class QuranChapterScreen extends StatelessWidget {
  const QuranChapterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.second,
        onPressed: () async {
          int? bookmarkedPage = await _getBookmark();
          if (bookmarkedPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuarnDBScreen(initPage: bookmarkedPage + 1),
              ),
            );
          } else {
            Fluttertoast.showToast(
              msg: 'No bookmark found!',
              backgroundColor: Colors.red,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        },
        child: const Icon(Icons.bookmark_border_outlined),
        // You can add more properties like backgroundColor, tooltip, etc.
      ),
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            isArabic()
                ? Icons.arrow_back_ios_sharp
                : Icons.arrow_back_ios_new_sharp,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: AppColors.primary,
          size: 20.size,
        ),
        title: Text(
          'المصحف المكتوب',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontFamily: "Almarai",
            fontStyle: FontStyle.normal,
            fontSize: 20.0.fontSize,
          ),
        ),
      ),
      body: BlocBuilder<QuranChapterCubit, QuranChapterState>(
        builder: (context, state) {
          if (state is QuranChapterLoadingState) {
            return const Center(
              child: LoadingWidget(),
            );
          } else if (state is QuranChapterSuccessState) {
            debugPrint("QuranChaptersSuccessState");
            return Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Image.asset(
                    'assets/image/helf_down_frame.png',
                    height: 175.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Column(
                  children: [
                    // Rectangle 39349
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.0.height,
                        left: 15.width,
                        right: 15.width,
                      ),
                      child: Container(
                        width: 330.width,
                        height: 48.height,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xffefe2ce),
                        ),
                        child: Center(
                          child: TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset('assets/svg/icon_search.svg'),
                                10.verticalSpace,
                                Text(
                                  'البحث في المصحف المكتوب',
                                  style: TextStyle(
                                      color: const Color(0x80634e36),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "Almarai",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0.fontSize),
                                ),
                              ],
                            ),
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SurhSearchScreen(
                                  quranChapterJson: state.quranChapter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.quranChapter.length,
                        itemBuilder: (context, index) {
                          final quranChapter = state.quranChapter[index];
                          return QuranChapterWidget(
                            quranSorhaName: state.quranChapter,
                            quranChapter: quranChapter,
                            index: index,

                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is QuranChapterErorrState) {
            return Center(
              child: Text('Error loading prayer times: ${state.errorMessage}'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<int?> _getBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('bookmark');
  }
}
