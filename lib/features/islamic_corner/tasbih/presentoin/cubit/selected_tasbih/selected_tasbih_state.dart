part of 'selected_tasbih_bloc.dart';

class SelectedTasbihState extends Equatable {
  final TasbihArray tasbih;
  final int count;
  const SelectedTasbihState(
      this.tasbih,
      this.count,
      );

  @override
  List<Object> get props => [tasbih, count];
}
