import 'package:ahmed_ragab/cubit/homeCubit.dart';
import 'package:ahmed_ragab/cubit/homeStates.dart';
import 'package:ahmed_ragab/dummyData/productsData.dart';
import 'package:ahmed_ragab/models/productModel.dart';
import 'package:ahmed_ragab/widgets/slideAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<ProductModel> cartDummyProducts =
            dummyProducts.where((element) => element.inCart!).toList();

        return Scaffold(
          appBar: AppBar(
              title: Text(
                'Cart',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              centerTitle: true),
          body: cartDummyProducts.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 30),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  itemCount: cartDummyProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CartProduct(productModel: cartDummyProducts[index]);
                  },
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.inbox, size: 120, color: Colors.grey[350]),
                      SizedBox(height: 20),
                      Text(
                        'Cart is Empty',
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class CartProduct extends StatelessWidget {
  CartProduct({this.productModel});
  final ProductModel? productModel;
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var theme = Theme.of(context);
    final SlidableController slidableController = new SlidableController();

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      controller: slidableController,
      secondaryActions: <Widget>[
        SlidableAction(
          slidableController: slidableController,
          productModel: productModel,
          isCart: true,
        ),
      ],
      child: Container(
        height: 141,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor,
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel!.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.subtitle1,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Total Price',
                          style: theme.textTheme.subtitle2,
                        ),
                        SizedBox(width: 10),
                        Text(
                          productModel!.currentPrice!.toString(),
                          style: theme.textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => cubit.removeQuantity(productModel!),
                          icon: Icon(Icons.remove),
                        ),
                        Text(
                          productModel!.quantity!.toString(),
                          style: theme.textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () => cubit.addQuantity(productModel!),
                          icon: Icon(Icons.add),
                        ),
                        SizedBox(width: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                child: productModel!.imageSrc!.isNotEmpty
                    ? Image.file(productModel!.imageSrc!.first)
                    : Center(child: Icon(Icons.error, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
