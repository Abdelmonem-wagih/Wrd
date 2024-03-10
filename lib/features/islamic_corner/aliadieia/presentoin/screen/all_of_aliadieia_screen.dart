// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/core/widget/loading_widget.dart';
import 'package:wrd/features/islamic_corner/aliadieia/presentoin/cubit/duea/duea_cubit.dart';
import '../../../../../core/utils/appbar_widget.dart';
import '../widgets/duea_grid_widget.dart';

class AllOfAliadieiaScreen extends StatelessWidget {
  const AllOfAliadieiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: 'الادعية'),


      body: BlocBuilder<DueaCubit, DueaState>(builder: (context, state) {
        if (state is DueaLoadingState) {
          print('DueaLoadingState');
          return Center(child: LoadingWidget());

        } else if (state is DueaSuccessState) {
          return Stack(
            children: [
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 20.0.width, // Spacing between columns
                  mainAxisSpacing: 20.0.height, // Spacing between rows
                ),
                padding: EdgeInsets.all(10.size),
                itemCount: state.duea.length,
                itemBuilder: (context, index) {
                  final duea = state.duea[index];
                  return GridTile(
                    child: DueaGridWidget(
                      duea: duea,
                    ),
                  );
                },
              ),
            ],
          );
        } else if (state is DueaErorrState) {
          print('DueaErorrState');
          return Center(
            child: Text('Error loading Duea: ${state.errorMessage}'),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}