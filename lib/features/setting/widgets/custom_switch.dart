import 'package:flutter/material.dart';
import 'package:wrd/core/services/screen_size_helper.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color activeColor;
  final Color inactiveColor;

  const CustomSwitch({super.key, 
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  });

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _value = false;

  @override
  void initState() {
    setState(() {
      _value = widget.value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        widget.onChanged?.call(_value);
      },
      child: Container(
        width: 70.0.width,
        height: 35.0.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: _value ? widget.activeColor : widget.inactiveColor,
        ),
        child: Stack(
          alignment: _value ? Alignment.centerRight : Alignment.centerLeft,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 33.0,
              height: 33.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
