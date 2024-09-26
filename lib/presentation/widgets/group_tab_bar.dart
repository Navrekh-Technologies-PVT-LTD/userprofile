import 'package:flutter/material.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/size_utils.dart';

class GroupTabBar extends StatelessWidget {
  final int listLength;
  final int selectedIndex;
  final Function(int i) onChangeIndex;
  const GroupTabBar({
    super.key,
    required this.listLength,
    required this.selectedIndex,
    required this.onChangeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          w(8),
          ...List.generate(listLength, (index) => index).map(
            (index) {
              bool isSelected = index == selectedIndex;
              return Material(
                color: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: index == 0
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            topLeft: Radius.circular(32),
                          )
                        : listLength - 1 == index
                            ? const BorderRadius.only(
                                topRight: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              )
                            : BorderRadius.zero,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: InkWell(
                    onTap: isSelected
                        ? null
                        : () {
                            onChangeIndex(index);
                          },
                    borderRadius: BorderRadius.circular(32),
                    child: Ink(
                      height: 31,
                      width: sizer(context, 0.14),
                      decoration: BoxDecoration(
                        color: isSelected ? TColor.msgbck : Colors.white,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Center(
                        child: Text(
                          "Group ${String.fromCharCode(65 + index)}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : TColor.grey51,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          w(8),
        ],
      ),
    );
  }
}
