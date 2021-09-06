import 'package:ahmed_ragab/utils/const.dart';
import 'package:ahmed_ragab/views/addProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmed_ragab/cubit/homeCubit.dart';
import 'package:ahmed_ragab/cubit/homeStates.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeBottomNav(index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                tooltip: 'See Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
                tooltip: 'User Profile',
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add Product',
            onPressed: () => navPush(context, AddProdcutScreen()),
            child: Icon(Icons.add),
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
        );
      },
    );
  }
}
