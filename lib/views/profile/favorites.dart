import 'package:ahmed_ragab/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmed_ragab/cubit/homeCubit.dart';
import 'package:ahmed_ragab/cubit/homeStates.dart';
import 'package:ahmed_ragab/dummyData/productsData.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ahmed_ragab/widgets/productItem.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<ProductModel> favDummyProducts =
            dummyProducts.where((element) => element.isFav!).toList();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Favorites',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          body: favDummyProducts.isNotEmpty
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: .365.sh,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  itemCount: favDummyProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductItem(
                      productModel: favDummyProducts[index],
                      isFav: true,
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.inbox, size: 120, color: Colors.grey[350]),
                      SizedBox(height: 20),
                      Text(
                        'No Favorites yet',
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
