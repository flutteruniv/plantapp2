import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation_model.dart';

class bottomNavigationButton extends StatelessWidget {
  const bottomNavigationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationModel>(
        create: (_) => BottomNavigationModel(),
        child: Consumer<BottomNavigationModel>(
        builder: (context, model, child)
    {
      final tabItems = [
        const BottomNavigationBarItem(
          icon: Icon(Icons.face),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          label: '',
        ),
      ];
    }),);
}
