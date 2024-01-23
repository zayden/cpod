import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class TempWidget extends StatefulWidget {
  final String title;
  final bool disabled;
  final double realTimeTemp;
  final int remainingTime;
  final int temp;
  final int time;
  final onOff;
  final ValueChanged<bool> onToggle;

  const TempWidget(
      {Key? key,
      required this.title,
      required this.disabled,
      required this.realTimeTemp,
      required this.remainingTime,
      required this.temp,
      required this.time,
      required this.onToggle,
      this.onOff})
      : super(key: key);

  @override
  State<TempWidget> createState() => _TempWidgetState();
}

class _TempWidgetState extends State<TempWidget> {
  final _tempController = TextEditingController();
  final _timeController = TextEditingController();
  final FocusNode focusNodeTemp = FocusNode();
  final FocusNode focusNodeTime = FocusNode();

  @override
  Widget build(BuildContext context) {
    _tempController.text = widget.temp.toString();
    _timeController.text = widget.time.toString();
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0x00808080),
              width: 2,
            ),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 8)
            ]),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(3)),
                  Text(widget.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.device_thermostat),
                            Text(
                                "${widget.disabled || !widget.onOff ? "--.--" : (widget.realTimeTemp / 100.0).toStringAsFixed(2)}℃"),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.access_time),
                            SizedBox(
                              child: Text(widget.disabled || !widget.onOff
                                  ? "--:--"
                                  : " ${(widget.remainingTime ~/ 60).toString().padLeft(2, '0')}:${(widget.remainingTime % 60).toString().padLeft(2, '0')}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 20.0, 1),
                    child: Row(
                      children: [
                        const Text("Temp"),
                        Expanded(
                            child: Center(
                          child: Text(widget.temp.toString()),
                        )),
                        const Text(
                          " ℃",
                          style: TextStyle(letterSpacing: 3.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5, 20.0, 10),
                    child: Row(
                      children: [
                        const Text("Time"),
                        Expanded(
                            child: Center(
                          child: Text(widget.time.toString()),
                        )),
                        const Text("min"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlutterSwitch(
                      value: widget.disabled ? false : widget.onOff,
                      showOnOff: true,
                      height: 30,
                      disabled: widget.disabled,
                      onToggle: (bool value) {
                        widget.onToggle(value);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
