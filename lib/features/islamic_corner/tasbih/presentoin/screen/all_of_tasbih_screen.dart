// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/islamic_corner/tasbih/presentoin/cubit/tasbih/tasbih_cubit.dart';

import '../../../../../core/utils/appbar_widget.dart';
import '../widgets/tasbih_grid_widget.dart';
import 'based_tasbih_screen.dart';
import 'tasbih_screen.dart';

class AllOfTasbihiScreen extends StatelessWidget {
  const AllOfTasbihiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: 'التسبيحات'),
      body: BlocBuilder<TasbihCubit, TasbihState>(builder: (context, state) {
        if (state is TasbihLoadingState) {
          debugPrint('DueaLoadingState');
          return Center(child: CircularProgressIndicator());
        } else if (state is TasbihSuccessState) {
          return Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Image.asset(
                  'assets/image/helf_down_frame.png',
                  height: 180.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 10.0.width, // Spacing between columns
                    mainAxisSpacing: 10.0.height, // Spacing between rows
                    //mainAxisExtent: 80.height,
                    childAspectRatio: 1.5.height),
                padding: EdgeInsets.all(10.radius),
                itemCount: state.tasbih.length,
                itemBuilder: (context, index) {
                  final tasbih = state.tasbih[index];
                  List<Map<String, dynamic>> goTasibhScreen = [
                    {'route': TasbihScreen(tasbihTest: tasbih)},
                    {'route': TasbihScreen(tasbihTest: tasbih)},
                    {
                      'route': BasedTasbihScreen(
                        tasbih: tasbih,
                      )
                    },
                  ];
                  final item = goTasibhScreen[index];
                  return GridTile(
                    child: TasbihGridWidget(
                      tasbih: tasbih,
                      item: item,
                    ),
                  );
                },
              ),
            ],
          );
        } else if (state is TasbihErorrState) {
          debugPrint('DueaErorrState');
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
