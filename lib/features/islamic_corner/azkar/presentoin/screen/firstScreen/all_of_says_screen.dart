// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/islamic_corner/azkar/presentoin/cubit/says/says_cubit.dart';
import '../../../../../../core/utils/appbar_widget.dart';
import '../../widgets/all_of_azkar_widget.dart';

class AllOfSaysScreen extends StatelessWidget {
  const AllOfSaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: 'ما يقول العبد'),
      body: BlocBuilder<SaysCubit, SaysState>(builder: (context, state) {
        if (state is SaysLoadingState) {
          debugPrint('SaysLoadingState');
          return Center(child: CircularProgressIndicator());
        } else if (state is SaysSuccessState) {
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
                itemCount: state.says.length,
                itemBuilder: (context, index) {
                  final says = state.says[index];

                  return AllOfAzkarGridWidget(
                    azkar: says,
                  );
                },
              ),
            ],
          );
        } else if (state is SaysErorrState) {
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
