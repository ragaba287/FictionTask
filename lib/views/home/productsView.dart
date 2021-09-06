import 'package:ahmed_ragab/cubit/homeCubit.dart';
import 'package:ahmed_ragab/cubit/homeStates.dart';
import 'package:ahmed_ragab/dummyData/productsData.dart';
import 'package:ahmed_ragab/utils/const.dart';
import 'package:ahmed_ragab/views/profile/cart.dart';
import 'package:ahmed_ragab/widgets/productItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsViewScreen extends StatelessWidget {
  @override
  Widget build(context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return dummyProducts.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inbox, size: 120, color: Colors.grey[350]),
                    SizedBox(height: 20),
                    Text(
                      'No Products yet',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              )
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total : ${cubit.totalPrice}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () => navPush(context, CartScreen()),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                // IconButton(
                                //   onPressed: () => navPush(context, CartScreen()),
                                //   icon: Icon(Icons.shopping_cart_outlined),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(Icons.shopping_cart_outlined),
                                ),
                                if (cubit.cartCount != 0)
                                  Positioned(
                                    right: 8.w,
                                    bottom: 5.w,
                                    child: Container(
                                      padding: EdgeInsets.all(4.w),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: accentColor),
                                      ),
                                      child: Center(
                                        child: Text(cubit.cartCount.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  fontSize: 12.sp,
                                                  // fontWeight: FontWeight.w800,
                                                )),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 35),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          mainAxisExtent: .48.sh,
                        ),
                        itemCount: dummyProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductItem(
                              productModel: dummyProducts[index]);
                        },
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
