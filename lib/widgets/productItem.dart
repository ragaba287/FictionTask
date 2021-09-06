import 'package:ahmed_ragab/cubit/homeCubit.dart';
import 'package:ahmed_ragab/models/productModel.dart';
import 'package:ahmed_ragab/widgets/slideAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductItem extends StatelessWidget {
  ProductItem({this.productModel, this.isFav = false});
  final ProductModel? productModel;
  final bool isFav;
  @override
  Widget build(BuildContext context) {
    bool saleOn = productModel!.oldPrice! != 0;
    final SlidableController slidableController = new SlidableController();

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.6,
      controller: slidableController,
      secondaryActions: <Widget>[
        SlideAction(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SlidableAction(
                  slidableController: slidableController,
                  productModel: productModel,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SlidableAction(
                  slidableController: slidableController,
                  productModel: productModel,
                  isCart: true,
                ),
              ),
            ],
          ),
        )
      ],
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          // border: Border.all(color: Colors.black),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: productModel!.imageSrc!.isNotEmpty
                  ? Image.file(productModel!.imageSrc!.first)
                  : Center(child: Icon(Icons.error, color: Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel!.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 5),
                  Text(
                    productModel!.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Price',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(width: 10),
                      Text(
                        productModel!.currentPrice!.toString(),
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: saleOn
                                  ? Colors.green
                                  : Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .color,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      SizedBox(width: 10),
                      if (saleOn)
                        Text(
                          productModel!.oldPrice!.toString(),
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                    ],
                  ),
                  SizedBox(height: 15),
                  if (!isFav)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () => HomeCubit.get(context)
                              .removeQuantity(productModel!),
                          icon: Icon(Icons.remove),
                        ),
                        Text(
                          productModel!.quantity!.toString(),
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        IconButton(
                          onPressed: () =>
                              HomeCubit.get(context).addQuantity(productModel!),
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
