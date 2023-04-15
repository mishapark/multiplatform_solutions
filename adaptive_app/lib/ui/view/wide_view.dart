import 'package:adaptive_app/data/user.dart';
import 'package:adaptive_app/data/menu_items.dart';
import 'package:adaptive_app/ui/widgets/popup_menu_item.dart';
import 'package:adaptive_app/ui/widgets/user_card_grid.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class WideView extends StatelessWidget {
  final List<User> usersList;
  const WideView({super.key, required this.usersList});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blue,
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Adaptive App',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              children: usersList
                  .map((user) => UserCardGrid(
                      firstname: user.firstname,
                      lastname: user.lastname,
                      email: user.email,
                      pic: user.pic,
                      onTap: () {
                        showPopover(
                          context: context,
                          bodyBuilder: (context) => ListView(
                            children: menuItems
                                .map((item) => MenuItem(
                                      title: item['title'],
                                      icon: item['icon'],
                                      onTap: () => Navigator.pop(context),
                                    ))
                                .toList(),
                          ),
                          onPop: () => print('Popover was popped!'),
                          direction: PopoverDirection.bottom,
                          width: 200,
                          height: 400,
                          arrowHeight: 15,
                          arrowWidth: 30,
                        );
                      }))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
