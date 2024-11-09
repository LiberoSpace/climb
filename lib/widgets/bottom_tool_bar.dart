import 'package:climb/styles/app_colors.dart';
import 'package:flutter/material.dart';

class BottomToolBar extends StatelessWidget {
  final List<BottomToolBarIconButtonData> iconButtonDataList;

  const BottomToolBar({
    super.key,
    required this.iconButtonDataList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 44,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 4,
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: iconButtonDataList.map((iconButtonData) {
          return Expanded(
            child: IconButton(
              onPressed: iconButtonData.onPressed,
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder())),
              alignment: Alignment.center,
              iconSize: 32,
              color: colorBlack,
              icon: iconButtonData.icon,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class BottomToolBarIconButtonData {
  Function()? onPressed;
  Icon icon;
  BottomToolBarIconButtonData({
    required this.onPressed,
    required this.icon,
  });
}
