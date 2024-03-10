// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/utils/app_colors.dart';
import '../../../../../core/bloc/true_false/boolCubit.dart';
import '../../../../../core/utils/appbar_widget.dart';
import '../../../../../core/widget/counter_widget.dart';
import '../../../azkar/presentoin/widgets/group_widget.dart';
import '../../domain/entities/duea.dart';

class DueaScreen extends StatelessWidget {
  final Duea dueaTest;
  DueaScreen({super.key, required this.dueaTest});

  int counter = 0;
  int length = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: dueaTest.category!),
      body: BlocProvider(
        create: (context) => BoolCubit(),
        child: BlocBuilder<BoolCubit, bool>(
          builder: (context, state) {
            return CarouselSlider.builder(
                autoSliderTransitionTime: Duration(milliseconds: 1),
                autoSliderDelay: Duration(milliseconds: 600),
                onSlideChanged: (voi) {
                  length = voi;
                  context.read<BoolCubit>().setFalse();
                  counter = 0;
                },
                enableAutoSlider: state &&
                    dueaTest.array.length > 1 &&
                    length < dueaTest.array.length - 1,
                initialPage: 0,
                itemCount: dueaTest.array.length,
                slideBuilder: (index) {
                  final dueaArray = dueaTest.array[index];

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            bottom: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: AppColors.primary,
                                ),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: '${dueaArray!.text}',
                                      style: TextStyle(
                                        height: 1.7,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Almarai",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20.0.fontSize,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: 25.height),
                              GroupWidget(
                                len: dueaTest.array.length,
                                widgetArray: dueaArray,
                              ),
                            ],
                          ),
                        ),
                        counterWidget(listArray: dueaArray, counter: counter),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
