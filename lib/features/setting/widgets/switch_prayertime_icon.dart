import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/switch_helper.dart';

class SwitchPrayerTimeIcon extends StatefulWidget {
  final int id;

  const SwitchPrayerTimeIcon({
    super.key,
    required this.id,
  });

  @override
  _SwitchPrayerTimeIconState createState() => _SwitchPrayerTimeIconState();
}

class _SwitchPrayerTimeIconState extends State<SwitchPrayerTimeIcon> {
  bool _switchValue = false;
  @override
  void initState() {
    super.initState();
    // Load switch state from SharedPreferences when the widget is initialized
    _loadSwitchState();
  }

  void _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Use the key "${widget.id}_switch" to uniquely identify the switch state
      _switchValue = prefs.getBool('${widget.id}_switchPrayerTime') ?? false;
    });
  }

  void _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Use the key "${widget.id}_switch" to uniquely identify the switch state
    prefs.setBool('${widget.id}_switchPrayerTime', value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _switchValue = !_switchValue;
        });
        _saveSwitchState(_switchValue);
      },
      child: SwitchHelper(switchValue: _switchValue),
    );
  }
}
