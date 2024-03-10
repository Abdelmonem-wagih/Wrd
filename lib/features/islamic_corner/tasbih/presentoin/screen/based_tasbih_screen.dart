// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrd/core/services/screen_size_helper.dart';
import 'package:wrd/features/islamic_corner/tasbih/domain/entities/tasbih.dart';
import '../../../../../core/utils/appbar_widget.dart';
import '../cubit/tasbih/tasbih_cubit.dart';
import '../widgets/based_tasbih_widget.dart';

class BasedTasbihScreen extends StatelessWidget {
  const BasedTasbihScreen({super.key, required this.tasbih});
  final Tasbih tasbih;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, appBarTitle: 'المسبحه'),
      body: BlocBuilder<TasbihCubit, TasbihState>(builder: (context, state) {
        if (state is TasbihLoadingState) {
          debugPrint('DueaLoadingState');
          return Center(child: CircularProgressIndicator());
        } else if (state is TasbihSuccessState) {
          return Column(
            children: [
              StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns in the grid
                          crossAxisSpacing: 20.0.width,
                          mainAxisSpacing: 20.0.height, // Spacing between rows
                        ),
                        padding: EdgeInsets.all(10),
                        itemCount: tasbih.array.length,
                        itemBuilder: (context, index) {
                          final tasibhArray = tasbih.array[index];
                          return GridTile(
                            child: BasedTasbihWidget(
                              tasbih: tasibhArray!,
                            ),
                          );
                        },
                      ),
                    );
                  }),
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
