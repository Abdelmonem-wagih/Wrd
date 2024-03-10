// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/widget/loading_widget.dart';
import '../../../../../../core/utils/appbar_widget.dart';
import '../../cubit/azkar/azkar_cubit.dart';
import '../../widgets/azkar_grid_widget.dart';

class AllOfAzkarsScreen extends StatelessWidget {
  const AllOfAzkarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: 'الأذكار'),
      body: BlocBuilder<AzkarCubit, AzkarState>(builder: (context, state) {
        if (state is AzkarLoadingState) {
          return Center(
            child: LoadingWidget(),
          );

        } else if (state is AzkarSuccessState) {
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
                  childAspectRatio: 1.6.width,
                ),
                padding: EdgeInsets.all(10.size),
                itemCount: state.azkar.length-2,
                itemBuilder: (context, index) {
                  final azkar = state.azkar[index+2];


                  return AzkarGridWidget(
                    azkar: azkar,
                  );
                },
              ),
            ],
          );
        } else if (state is AzkarErorrState) {
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
