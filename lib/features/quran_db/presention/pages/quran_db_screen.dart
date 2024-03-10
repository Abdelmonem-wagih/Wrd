// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrd/core/services/screen_size_helper.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../frosted_glass_audio.dart';
import '../../../../main.dart';
import '../../domain/entities/quran_chapter.dart';
import '../controller/db_helper.dart';

class QuarnDBScreen extends StatefulWidget {
  final int initPage;
  final List<QuranChapter>? quranSorhaName;

  const QuarnDBScreen({
    super.key,
    required this.initPage,
    this.quranSorhaName,
  });
  @override
  _QuarnDBScreenState createState() => _QuarnDBScreenState();
}

class _QuarnDBScreenState extends State<QuarnDBScreen> {
  int? _selectedItemIndex;

  // Database helper instance
  DatabaseHelper dbHelper = DatabaseHelper();
  // List to store fetched data
  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> jozList = [];
  // List<Map<String, dynamic>> soreList = [];

  late int pageNumber;
  bool isFirst = false;
  int checkPage = 0;
  int testPage = 0;
  int page = 0;
  late String currentData; // Variable for the current data

  final bool _isBookmarked = false;
  late PageController pageController;
  bool _isContainerVisible = false;
  late PageController _pageController;
  late int _currentPage;

  void toggleContainerVisibility() {
    setState(() {
      _isContainerVisible = !_isContainerVisible;
    });
  }

  late String joz;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    joz = '';
    isFirst = true;
    pageNumber = widget.initPage;
    fetchData();
    page = widget.initPage;
    pageController = PageController(
      initialPage: page - 1,
    );
    _loadBookmark();
  }

  // Function to save bookmarked page index to SharedPreferences
  Future<void> _saveBookmark(int pageIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bookmark', pageIndex);
  }

  // Function to retrieve bookmarked page index from SharedPreferences
  Future<void> _loadBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    int? bookmarkedPage = prefs.getInt('bookmark');
    if (bookmarkedPage != null) {
      setState(() {
        _currentPage = bookmarkedPage;
      });
      pageController = PageController(initialPage: bookmarkedPage);
    }
  }

  void _scrollToPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(seconds: 1), // Set the desired duration
      curve: Curves.slowMiddle, // Set the desired curve for animation
    );
  }

  // Method to fetch data from the SQLite database
  void fetchData() async {
    try {
      dataList = await dbHelper.fetchDataFromTableBySurahId(pageNumber);
      currentData = dataList.toString();
      setState(() {});
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_isBookmarked before build $_isBookmarked');

    return Scaffold(
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
        iconTheme: const IconThemeData(
          color: AppColors.primary,
          size: 20,
        ),
        title: Text(
          'السابق',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontFamily: "Almarai",
            fontStyle: FontStyle.normal,
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _saveBookmark(_currentPage);
                Fluttertoast.showToast(
                  msg: 'Bookmark saved for page ${_currentPage + 1}',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                ); // Bookmark the current page

                // Save the current page when the bookmark icon is pressed
              },
              icon: Icon(Icons.bookmark)),
          TextButton(
            onPressed: toggleContainerVisibility,
            child: Container(
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: AppColors.primary,
              ),
              child: Center(
                child: Text(
                  ' الجـــزء  $joz ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Almarai",
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0.fontSize,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                itemCount: 604,
                controller: pageController,
                scrollDirection: Axis.horizontal,
                reverse: false,
                onPageChanged: (value) {
                  setState(() {
                    pageNumber = value + 1;
                    _currentPage = value;
                  });
                  fetchData();
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SelectableText.rich(
                      textScaleFactor:
                          MediaQuery.of(context).size.height * 0.0016,
                      textAlign: TextAlign.justify,
                      TextSpan(
                        children: List.generate(dataList.length, (index2) {
                          debugPrint(
                              'dataList.length=>>>>>>>>>>>>${dataList.length}');
                          String ayaText = dataList[index2]['text']
                              .toString()
                              .replaceAll('(', '')
                              .replaceAll(')', '')
                              .replaceAll(RegExp(r"[0-9]+"), "");
                          joz = dataList[index2]['joza'].toString();
                          String ayaNumber =
                              dataList[index2]['ayaid'].toString();
                          int soreNumber = dataList[index2]['soraid'];

                          return ayaNumber == '0'
                              ? TextSpan(text: '')
                              : TextSpan(
                                  children: [
                                    ayaNumber == '1'
                                        ? TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Container(
                                                  height: 50.height,
                                                  width: 300.width,
                                                  decoration:
                                                      const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        'assets/image/icon_isolation_mode.png',

                                                      ),
                                                      fit: BoxFit.fill
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      widget.quranSorhaName![soreNumber - 1].nameArabic!,
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            "ae_Granada",
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 30.0.fontSize,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: soreNumber == 9
                                                    ? Container()
                                                    : Image.asset(
                                                        'assets/image/icon_basmala_1.png',
                                                      ),
                                              )
                                            ],
                                          )
                                        : TextSpan(text: ''),
                                    TextSpan(
                                      text: ayaText,
                                      style: TextStyle(
                                        color: AppColors.darkTone,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'UthmanicHafs',
                                        fontStyle: FontStyle.normal,
                                        fontSize: 17.0.fontSize,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ﴿$ayaNumber﴾ ',
                                      style: TextStyle(
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ],
                                );
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: _isContainerVisible,
            child: Padding(
              padding: const EdgeInsets.only(right: 120.0, top: 20),
              child: FrostedGlassAudio(
                theHeight: 600.height,
                theChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0.height, horizontal: 20.width),
                      child: Text(
                        "أجزاء المصحف",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Almarai",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0.fontSize,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0.width),
                        child: Scrollbar(
                          thumbVisibility: true,
                          trackVisibility: true,
                          child: ListView.builder(
                            itemCount: 30,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedItemIndex = index;
                                  });
                                  _scrollToPage((index * 20) + 1);
                                  toggleContainerVisibility();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 8.0),
                                      child: Container(
                                        height: 25.height,
                                        width: 25.width,
                                        color: AppColors.primary,
                                        child: Center(
                                          child: Text(
                                            "${index + 1}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      'الجـــزء ${index + 1}',
                                      style: TextStyle(
                                        color: AppColors.darkTone,
                                        fontWeight: _selectedItemIndex == index
                                            ? FontWeight.bold
                                            : FontWeight.w400,
                                        fontFamily: "Almarai",
                                        fontStyle: FontStyle.normal,
                                        fontSize: _selectedItemIndex == index
                                            ? 20.0.fontSize
                                            : 16.fontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
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
