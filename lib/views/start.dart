import 'package:ahmed_ragab/utils/const.dart';
import 'package:ahmed_ragab/views/home/home.dart';
import 'package:ahmed_ragab/widgets/mainButton.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                InfoWidget(theme: theme, title: 'Name: Ahmed Ragab'),
                InfoWidget(theme: theme, title: 'Phone +201026612529'),
                InfoWidget(theme: theme, title: 'Email: ragaba287@gmail.com'),
                MainButton(
                  title: 'Run App',
                  onPressed: () => navPush(context, HomeScreen()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///InfoWidget Card is locally used only for the
class InfoWidget extends StatelessWidget {
  const InfoWidget({
    required this.theme,
    this.title = '',
  });

  final ThemeData theme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        title,
        style: theme.textTheme.headline5,
      ),
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: theme.textTheme.headline5!.color!.withOpacity(.40)),
      ),
    );
  }
}
