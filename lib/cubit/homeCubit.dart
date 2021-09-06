import 'dart:io';

import 'package:ahmed_ragab/dummyData/productsData.dart';
import 'package:ahmed_ragab/models/productModel.dart';
import 'package:ahmed_ragab/utils/sharedpreference.dart';
import 'package:ahmed_ragab/views/home/settingsView.dart';
import 'package:ahmed_ragab/views/home/productsView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmed_ragab/cubit/homeStates.dart';
import 'package:image_picker/image_picker.dart';

bool isDarkMode = false;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);
  TextEditingController nameTextEditing = TextEditingController();
  TextEditingController descTextEditing = TextEditingController();
  TextEditingController oldPriceTextEditing = TextEditingController(text: '1');
  TextEditingController newPriceTextEditing = TextEditingController();
  TextEditingController quantTextEditing = TextEditingController(text: '1');

  void changeThemeMode(bool swtichValue) {
    isDarkMode = swtichValue;
    Sharedpreference.saveData(key: 'isDarkMode', value: isDarkMode);
    emit(HomeChangeThemeModeState());
  }

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsViewScreen(),
    ProfileScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(HomeChangeNavState());
  }

  int totalPrice = 0;
  void getTotalPrice() {
    totalPrice = 0;
    dummyProducts.forEach((element) {
      if (element.oldPrice! >= 0)
        totalPrice += element.currentPrice!;
      else
        totalPrice += element.oldPrice!;
    });
  }

  void addProduct() {
    dummyProducts.add(ProductModel(
      name: nameTextEditing.text,
      description: descTextEditing.text,
      imageSrc: imageFiles.toList(),
      currentPrice: newPriceTextEditing.text.isNotEmpty
          ? int.parse(newPriceTextEditing.text)
          : int.parse(oldPriceTextEditing.text),
      oldPrice: newPriceTextEditing.text.isNotEmpty
          ? int.parse(oldPriceTextEditing.text)
          : 0,
      quantity: quantTextEditing.text.isNotEmpty
          ? int.parse(quantTextEditing.text)
          : 0,
    ));
    imageFiles.clear();
    checkSale(false);

    getTotalPrice();
    emit(HomeAddProductState());
  }

  int cartCount = 0;
  void addToCart(ProductModel productModel) {
    dummyProducts[dummyProducts.indexOf(productModel)].inCart = true;
    cartCount =
        dummyProducts.where((element) => element.inCart!).toList().length;

    emit(HomeAddToCartState());
  }

  void removeFromCart(ProductModel productModel) {
    dummyProducts[dummyProducts.indexOf(productModel)].inCart = false;
    cartCount =
        dummyProducts.where((element) => element.inCart!).toList().length;

    emit(HomeAddToCartState());
  }

  void addOrRemoveFav(ProductModel productModel) {
    dummyProducts[dummyProducts.indexOf(productModel)].isFav =
        !dummyProducts[dummyProducts.indexOf(productModel)].isFav!;
    emit(HomeAddToCartState());
  }

  void addQuantity(ProductModel productModel) {
    dummyProducts[dummyProducts.indexOf(productModel)].quantity =
        dummyProducts[dummyProducts.indexOf(productModel)].quantity! + 1;
    emit(HomeAddQuantityState());
  }

  void removeQuantity(ProductModel productModel) {
    if (dummyProducts[dummyProducts.indexOf(productModel)].quantity! > 1)
      dummyProducts[dummyProducts.indexOf(productModel)].quantity =
          dummyProducts[dummyProducts.indexOf(productModel)].quantity! - 1;
    else
      dummyProducts.removeWhere((element) => element == productModel);
    getTotalPrice();
    emit(HomeRemoveQuantityState());
  }

  bool hasSale = false;
  void checkSale(bool sale) {
    hasSale = sale;
    emit(HomeHasSaleState());
  }

  List<File> imageFiles = [];
  var pickedImage;
  void imagePicker({ImageSource imageSource = ImageSource.gallery}) async {
    pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage == null) return;
    imageFiles.add(File(pickedImage.path));
    emit(HomeHasSaleState());
  }

  void deletePickedImages(int index) async {
    imageFiles.removeAt(index);
    emit(HomeHasSaleState());
  }
}
