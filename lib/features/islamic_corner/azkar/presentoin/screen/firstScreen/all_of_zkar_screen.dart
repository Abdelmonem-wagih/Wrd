// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/widget/loading_widget.dart';
import '../../../../../../core/utils/appbar_widget.dart';
import '../../cubit/zkar/zkar_cubit.dart';
import '../../widgets/all_of_azkar_widget.dart';

class AllOfZkarsScreen extends StatelessWidget {
  const AllOfZkarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: 'الذكر'),
      body: BlocBuilder<ZkarCubit, ZkarState>(builder: (context, state) {
        if (state is ZkarLoadingState) {
          debugPrint('ZkarLoadingState');
          return Center(child: LoadingWidget());
        } else if (state is ZkarSuccessState) {
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
                itemCount: state.zkar.length,
                itemBuilder: (context, index) {
                  final zkar = state.zkar[index];

                  return AllOfAzkarGridWidget(
                    azkar: zkar,
                  );
                },
              ),
            ],
          );
        } else if (state is ZkarErorrState) {
          debugPrint('AzkarErorrState');
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
