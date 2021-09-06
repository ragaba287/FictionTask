import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmed_ragab/views/profile/cart.dart';
import 'package:ahmed_ragab/views/profile/favorites.dart';
import 'package:ahmed_ragab/cubit/homeCubit.dart';
import 'package:ahmed_ragab/cubit/homeStates.dart';
import 'package:ahmed_ragab/utils/const.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var theme = Theme.of(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(25, 100, 25, 0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://cdn3.f-cdn.com/ppic/124988647/logo/33112246/Facebook_33112246.jpg'),
                  ),
                  SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ahmed Ragab',
                        style: theme.textTheme.subtitle1,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'ragaba287@gmail.com',
                        style: theme.textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              SettingButton(
                onTap: () {},
                switchState: isDarkMode,
                switchFunction: (value) => cubit.changeThemeMode(value),
                iconColor: Colors.purple[900]!,
              ),
              SettingButton(
                onTap: () => navPush(context, FavoritesScreen()),
                icon: Icons.favorite,
                iconColor: Colors.red[400]!,
                title: 'Favorites',
              ),
              SettingButton(
                onTap: () => navPush(context, CartScreen()),
                icon: Icons.shopping_cart,
                iconColor: Colors.teal,
                title: 'Cart',
              ),
            ],
          ),
        );
      },
    );
  }
}

class SettingButton extends StatelessWidget {
  SettingButton({
    this.iconColor = const Color(0xff5568FE),
    this.icon = Icons.brightness_2,
    this.title = 'Dark Mode',
    required this.onTap,
    this.switchState,
    this.switchFunction,
  });
  final Color iconColor;
  final IconData icon;
  final String title;
  final Function onTap;
  final bool? switchState;
  final Function? switchFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 25),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white),
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Spacer(),
            switchState != null
                ? CupertinoSwitch(
                    activeColor: accentColor,
                    value: switchState!,
                    onChanged: (value) => switchFunction!(value),
                  )
                : Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      ),
    );
  }
}
