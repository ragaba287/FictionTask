import 'package:ahmed_ragab/cubit/homeCubit.dart';
import 'package:ahmed_ragab/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableAction extends StatelessWidget {
  SlidableAction({
    required this.productModel,
    required this.slidableController,
    this.isCart = false,
  });

  final ProductModel? productModel;
  final SlidableController slidableController;
  final bool isCart;

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          if (!isCart)
            cubit.addOrRemoveFav(productModel!);
          else
            cubit.addToCart(productModel!);
          slidableController.activeState?.close();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${productModel!.name} Added to ${isCart ? 'cart' : 'favorite'}',
                style: theme.textTheme.subtitle2!.copyWith(color: Colors.black),
              ),
              backgroundColor: isCart ? theme.accentColor : Colors.red[100],
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: isCart ? theme.accentColor : Colors.red[400],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isCart ? Icons.shopping_cart : Icons.favorite),
              Text(
                isCart ? 'Cart' : 'Favorite',
                style: theme.textTheme.subtitle2!.copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
