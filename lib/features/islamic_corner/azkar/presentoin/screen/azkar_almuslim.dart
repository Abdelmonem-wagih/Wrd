// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/islamic_corner/azkar/presentoin/screen/firstScreen/all_of_azkars_screen.dart';
import 'package:wrd/features/islamic_corner/azkar/presentoin/screen/firstScreen/all_of_haju_screen.dart';
import 'package:wrd/features/islamic_corner/azkar/presentoin/screen/firstScreen/all_of_says_screen.dart';
import 'package:wrd/features/islamic_corner/azkar/presentoin/screen/firstScreen/all_of_tashahhud_screen.dart';
import 'package:wrd/features/islamic_corner/azkar/presentoin/screen/firstScreen/all_of_tawba_screen.dart';
import 'package:wrd/features/islamic_corner/azkar/presentoin/screen/firstScreen/all_of_zkar_screen.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/appbar_widget.dart';
import '../../../../../core/widget/loading_widget.dart';
import '../cubit/azkar/azkar_cubit.dart';
import '../widgets/azkar_grid_widget.dart';

class AzkarAlmuslim extends StatelessWidget {
  AzkarAlmuslim({super.key});

  List azkarAlmuslim = [
    ['الاذكار', const AllOfAzkarsScreen()],
    ['الذكر', const AllOfZkarsScreen()],
    ['الاستغفار والتوبة', const AllOfTawbaScreen()],
    ['التشهد والصلاة علي النبي', const AllOfTashahhudScreen()],
    ['الحج', const AllOfHajuScreen()],
    ['ما يقول العبد', const AllOfSaysScreen()]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: 'أذكار المسلم'),
      body: Stack(
        children: [
          Positioned(
            bottom: 0.height,
            child: Image.asset(
              'assets/image/helf_down_frame.png',
              height: 180.height,
            ),
          ),
          BlocBuilder<AzkarCubit, AzkarState>(
            builder: (context, state) {
              if (state is AzkarLoadingState) {
                return const Center(
                  child: LoadingWidget(),
                );
              } else if (state is AzkarSuccessState) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      crossAxisSpacing: 20.0.width, // Spacing between columns
                      mainAxisSpacing: 20.0.height,
                      childAspectRatio: 1.6.width // Spacing between rows
                      ),
                  padding: EdgeInsets.all(10.size),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return index <= 1?AzkarGridWidget(azkar:state.azkar[index],): InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => azkarAlmuslim[index-2][1],
                        ),
                      ),
                      child: Container(
                        width: 16.width,
                        height: 92.height,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.radius),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2.0,
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            azkarAlmuslim[index-2][0],
                            style: TextStyle(
                              color: AppColors.baseWhite,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Almarai",
                              fontStyle: FontStyle.normal,
                              fontSize: 22.0.fontSize,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }else if (state is AzkarErorrState) {
                print('AzkarErorrState');
                return Center(
                  child: Text('Error loading prayer times: ${state.errorMessage}'),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
