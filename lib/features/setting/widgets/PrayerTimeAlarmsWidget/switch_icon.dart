import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/bloc/true_false/boolCubit.dart';
import '../../../../core/services/alarm_helper.dart';
import '../../../../core/services/switch_helper.dart';

class SwitchIcon extends StatefulWidget {
  final int id;
  final String prayerTime;
  final String prayerTimeName;
  final bool onOffPrayerTimeSwitch;
  final int stateNumber;

  const SwitchIcon({
    super.key,
    required this.id,
    required this.prayerTime,
    required this.prayerTimeName,
    required this.onOffPrayerTimeSwitch,
    required this.stateNumber,
  });

  @override
  _SwitchIconState createState() => _SwitchIconState();
}

class _SwitchIconState extends State<SwitchIcon> {
  bool _switchValue = false;
  @override
  void initState() {
    super.initState();
    // Load switch state from SharedPreferences when the widget is initialized
    _loadSwitchState();
  }

  void _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (widget.stateNumber == 0) {
      // Reset SharedPreferences value to false for each ID in the list
      for (int id in [1, 2, 3, 4, 5, 6, 7]) {
        await prefs.setBool('${id}PrayerTime', false);
      }
    } else {
      setState(() {
        _switchValue = prefs.getBool('${widget.id}PrayerTime') ?? false;
      });
    }
  }

  void _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('${widget.id}PrayerTime', value);
  }

  @override
  Widget build(BuildContext context) {
    print(_switchValue);
    return GestureDetector(
      onTap: () async {
        context.read<NumberCubit>().setNumber(1);
        _switchValue = !_switchValue;
        context.read<SwitchPrayerCubit>().turnOn(widget.id, _switchValue);

        if (widget.onOffPrayerTimeSwitch == true) {
          _saveSwitchState(_switchValue);
        } else {
          setState(() {
            _switchValue = false;
          });
          _saveSwitchState(false);
        }
        if (_switchValue) {
          print('AlarmHelper on =>>>>>>>>>>>>>>>$_switchValue');
          widget.prayerTimeName == 'الفجْر'
              ? AlarmHelper.createFajrAlarm(
                  prayerTimeName: widget.prayerTimeName,
                  id: widget.id,
                  prayerTime: widget.prayerTime,
                )
              : widget.prayerTimeName == 'الشروق' ||
                      widget.prayerTimeName == 'الثلث الأخير من الليل'
                  ? AlarmHelper.createSunriseAlarm(
                      prayerTimeName: widget.prayerTimeName,
                      id: widget.id,
                      prayerTime: widget.prayerTime,
                      body: widget.prayerTimeName == 'الشروق'
                          ? ' قُل الحمدُ للهِ الَّذي أقالنا يومَنا هذا  ولم يُهلِكْنا بذنوبِنا'
                          : 'يَنْزِلُ رَبُّنا تَبارَكَ وتَعالَى كُلَّ لَيْلةٍ إلى السَّماءِ الدُّنْيا حِينَ يَبْقَى ثُلُثُ اللَّيْلِ الآخِرُ،'
                              ' يقولُ: مَن يَدْعُونِي، فأسْتَجِيبَ له؟ مَن يَسْأَلُنِي فأُعْطِيَهُ؟ مَن يَستَغْفِرُني فأغْفِرَ له؟',
                    )
                  : AlarmHelper.createPrayerTimeAlarm(
                      prayerTimeName: widget.prayerTimeName,
                      id: widget.id,
                      prayerTime: widget.prayerTime,
                      // muezzin: widget.muezzin,
                    );
        } else {
          await AlarmHelper.cancelReminder(id: widget.id);
        }
      },
      child: SwitchHelper(switchValue: _switchValue),

    );
  }
}

class NumberCubit extends Cubit<int> {
  NumberCubit() : super(2) {
    _loadNumber();
  }

  Future<void> _loadNumber() async {
    final prefs = await SharedPreferences.getInstance();
    final savedNumber = prefs.getInt('savedNumber');
    if (savedNumber != null) {
      emit(savedNumber);
    }
  }

  Future<void> setNumber(int number) async {
    emit(number);
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('savedNumber', number);
  }
}
