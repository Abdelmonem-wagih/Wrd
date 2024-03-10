import 'package:flutter/material.dart';
import 'package:wrd/core/utils/app_colors.dart';
import 'package:wrd/main.dart';

import '../../domain/entities/quran_chapter.dart';
import 'quran_chapter_widget.dart';

class SurhSearchScreen extends StatefulWidget {
  final List<QuranChapter> quranChapterJson;
  const SurhSearchScreen({
    super.key,
    required this.quranChapterJson,
  });
  @override
  _SurhSearchScreenState createState() => _SurhSearchScreenState();
}

class _SurhSearchScreenState extends State<SurhSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<QuranChapter> _searchResults = [];

  void _performSearch(String query) {
    // Clear previous search results.
    _searchResults.clear();

    // Filter _allArabicStrings to find matches and update _searchResults.
    for (QuranChapter arabicString in widget.quranChapterJson) {
      if (arabicString.nameArabic!.contains(query)) {
        _searchResults.add(arabicString);
      }
    }

    // Update the UI.
    setState(() {});
  }

// void _onDueaTapped(Duea duea) {
//   // Navigate to the DueaDetailScreen when a Duea is tapped.
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => DueaScreen(dueaTest: widget.duea,)),
//   );
// }
  @override
  Widget build(BuildContext context) {
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
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(
          color: AppColors.primary,
          size: 20,
        ),
        title: const Text(
          'البحث في المصحف المكتوب',
          style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontFamily: "Almarai",
              fontStyle: FontStyle.normal,
              fontSize: 20.0),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                hintText: " ابحث...",
                filled:
                    true, // This makes the background color fill the TextField
                fillColor: Color(0xb2faeab1),
              ),
              onChanged: (query) {
                _performSearch(query);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return QuranChapterWidget(
                  quranChapter: _searchResults[index],
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
