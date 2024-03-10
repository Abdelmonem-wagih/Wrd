// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/widget/loading_widget.dart';
import 'package:wrd/features/islamic_corner/azkar/presentoin/cubit/tashahhud/tashahhud_cubit.dart';
import '../../../../../../core/utils/appbar_widget.dart';
import '../../widgets/all_of_azkar_widget.dart';

class AllOfTashahhudScreen extends StatelessWidget {
  const AllOfTashahhudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: 'التشهد والصلاة علي النبي'),


      body: BlocBuilder<TashahhudCubit, TashahhudState>(
          builder: (context, state) {
            if (state is TashahhudLoadingState) {
              print('TashahhudLoadingState');
              return Center(child: LoadingWidget());
            } else if (state is TashahhudSuccessState) {
              return Stack(
                children: [
                  Positioned(
                    bottom: 0.height,
                    child: Image.asset(
                      'assets/image/helf_down_frame.png',
                      height: 180.height,

                    ),
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      crossAxisSpacing: 20.0.width, // Spacing between columns
                      mainAxisSpacing: 20.0.height,
                      childAspectRatio: 1.6.width,),
                    padding: EdgeInsets.all(10.size),
                    itemCount: state.tashahhud.length,
                    itemBuilder: (context, index) {
                      final tashahhud = state.tashahhud[index];

                      return AllOfAzkarGridWidget(
                        azkar: tashahhud,
                      );
                    },
                  ),
                ],
              );
            } else if (state is TashahhudErorrState) {
              print('AzkarErorrState');
              return Center(
                child: Text('Error loading prayer times: ${state.errorMessage}'),
              );
            } else {
              return Container();
            }
          }),

    );
  }
}