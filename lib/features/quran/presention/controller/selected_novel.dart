import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedNameWidget extends StatelessWidget {
  const SelectedNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedName = context.watch<SelectedNameProvider>().selectedName;

    return Text(
      selectedName.isNotEmpty ? selectedName : 'No Name Selected',
      style: const TextStyle(fontSize: 20),
    );
  }
}

class SelectedNameProvider extends ChangeNotifier {
  String _selectedName = '';

  String get selectedName => _selectedName;

  void updateSelectedName(String name) {
    _selectedName = name;
    notifyListeners();
  }
}
