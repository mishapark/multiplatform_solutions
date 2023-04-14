import 'package:adaptive_app/model/user.dart';
import 'package:adaptive_app/util/menu_items.dart';
import 'package:adaptive_app/widgets/popup_menu_item.dart';
import 'package:adaptive_app/widgets/user_card.dart';
import 'package:flutter/material.dart';

class NarrowView extends StatelessWidget {
  final List<User> usersList;
  const NarrowView({super.key, required this.usersList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: usersList
            .map(
              (user) => UserCard(
                firstname: user.firstname,
                lastname: user.lastname,
                email: user.email,
                pic: user.pic,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: menuItems
                                .map((item) => MenuItem(
                                      title: item['title'],
                                      icon: item['icon'],
                                      onTap: () => Navigator.pop(context),
                                    ))
                                .toList(),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
