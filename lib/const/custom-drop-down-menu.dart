import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/const/theme.dart';


// ignore: must_be_immutable
class CustomDropDownMenu extends StatefulWidget {
  String selectedValue;
  final List<String> option;
  ValueChanged<String> onSelectedChanged;
  CustomDropDownMenu(
      {super.key,
      required this.selectedValue,
      required this.option,
      required this.onSelectedChanged});

  @override
  _CustomDropDownMenuState createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  RxBool hovering = false.obs;
  RxBool clicked = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onHover: (value) {
            hovering.toggle();
          },
          child: Container(
            
            width: getWidth(context) * 0.2,
            decoration: BoxDecoration(
              
                border: Border.all(
                    color: hovering.value ? Colors.grey : red, width: 2.0),
                borderRadius: BorderRadius.circular(5.0)),
            child: DropdownButton(
              isExpanded: true,
              dropdownColor:Colors.white,
              value: widget.selectedValue,
              focusColor:Colors.grey.withOpacity(0.05),
              icon: const Icon(Icons.keyboard_arrow_down),
              
              underline: Container(
                
              ),
              items: widget.option.map((String items) {
                return DropdownMenuItem(
                  
                  value: items,
                  child: Container(
                      // width: getWidth(context) * 0.16,
                      margin:const EdgeInsets.only(left:5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(items)),
                );
              }).toList(),
              
              // alignment:AlignmentDirectional.,
              onChanged: (String? newValue) {
                setState(() async {
                  print('value is hhahaha $newValue');
                  hovering.toggle();
                  widget.selectedValue = newValue!;
                  widget.onSelectedChanged(widget.selectedValue);
                  hovering.toggle();
                });
              },
            ),
          ),
        ));
  }
}

Widget containerWithWidget(Widget widget, BuildContext context) {
  RxBool hovering = false.obs;
  return Obx(() => MouseRegion(
        onEnter: (_) {
          hovering.toggle();
        },
        onExit: (_) {
          hovering.toggle();
        },
        child: Container(
          width: getWidth(context) * 0.2,
          decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(
                  color: hovering.value ? Colors.grey : red, width: 2.0),
              borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: widget,
          ),
        ),
      ));
}
