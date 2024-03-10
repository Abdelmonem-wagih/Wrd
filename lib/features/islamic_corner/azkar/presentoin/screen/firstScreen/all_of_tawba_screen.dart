// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import '../../../../../../core/utils/appbar_widget.dart';
import '../../cubit/tawba/tawba_cubit.dart';
import '../../widgets/all_of_azkar_widget.dart';

class AllOfTawbaScreen extends StatelessWidget {
  const AllOfTawbaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: 'الاستغفار والتوبة'),
      body: BlocBuilder<TawbaCubit, TawbaState>(builder: (context, state) {
        if (state is TawbaLoadingState) {
          debugPrint('TawbaLoadingState');
          return Center(child: CircularProgressIndicator());
        } else if (state is TawbaSuccessState) {
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
                itemCount: state.tawba.length,
                itemBuilder: (context, index) {
                  final tawba = state.tawba[index];

                  return AllOfAzkarGridWidget(
                    azkar: tawba,
                  );
                },
              ),
            ],
          );
        } else if (state is TawbaErorrState) {
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
