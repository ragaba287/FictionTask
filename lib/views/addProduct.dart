import 'package:ahmed_ragab/cubit/homeCubit.dart';
import 'package:ahmed_ragab/cubit/homeStates.dart';
import 'package:ahmed_ragab/utils/const.dart';
import 'package:ahmed_ragab/views/home/home.dart';
import 'package:ahmed_ragab/widgets/mainButton.dart';
import 'package:ahmed_ragab/widgets/mainTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddProdcutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var theme = Theme.of(context);
        var cubit = HomeCubit.get(context);

        var _formKey = GlobalKey<FormState>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add New Product',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainTextFormField(
                      labelText: 'Name',
                      textEditingController: cubit.nameTextEditing,
                      validator: (String value) {
                        if (value.isEmpty) return 'Name can\'t be empty';
                      },
                    ),
                    MainTextFormField(
                      labelText: 'Description',
                      textEditingController: cubit.descTextEditing,
                      maxLines: 5,
                      validator: (String value) {
                        if (value.isEmpty) return 'Description can\'t be empty';
                      },
                    ),
                    Row(
                      crossAxisAlignment: cubit.hasSale
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: .3.sw,
                          child: MainTextFormField(
                              labelText: 'Price',
                              textEditingController: cubit.oldPriceTextEditing,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              validator: (String value) {
                                if (value.isEmpty)
                                  return 'Price Can\'t be empty';
                              }),
                        ),
                        if (!cubit.hasSale)
                          Checkbox(
                            value: cubit.hasSale,
                            activeColor: theme.accentColor,
                            onChanged: (value) => cubit.checkSale(true),
                          ),
                        if (!cubit.hasSale)
                          Text(
                            'Has sale',
                            style: theme.textTheme.subtitle1,
                          ),
                        if (cubit.hasSale) SizedBox(width: 50),
                        if (cubit.hasSale)
                          Container(
                            width: .3.sw,
                            child: MainTextFormField(
                              labelText: 'New Price',
                              textEditingController: cubit.newPriceTextEditing,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              validator: (String value) {
                                if (value.isEmpty) return 'New Price is empty';
                                if (int.parse(value) >=
                                    int.parse(cubit.oldPriceTextEditing.text))
                                  return 'Too High Sale';
                              },
                            ),
                          ),
                      ],
                    ),
                    Container(
                      width: .3.sw,
                      child: MainTextFormField(
                        textEditingController: cubit.quantTextEditing,
                        labelText: 'Stock',
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        validator: (String value) {
                          if (value.isEmpty) return 'Stock Can\'t be empty';
                          if (int.parse(value) <= 0) return 'Stock is too low';
                        },
                      ),
                    ),
                    Wrap(
                      children: List.generate(
                        cubit.imageFiles.length + 1,
                        (index) => ImagePickerCon(index),
                      ),
                      spacing: 10.w,
                      runSpacing: 10.w,
                    ),
                    SizedBox(height: 30),
                    MainButton(
                      title: 'Add',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          HomeCubit.get(context).addProduct();
                          cubit.nameTextEditing.clear();
                          cubit.descTextEditing.clear();
                          cubit.oldPriceTextEditing.clear();
                          cubit.newPriceTextEditing.clear();
                          cubit.quantTextEditing.clear();
                          navPushRemove(context, HomeScreen());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ImagePickerCon extends StatelessWidget {
  ImagePickerCon(this.index);
  final int? index;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cubit = HomeCubit.get(context);
    return InkWell(
      onTap: () async {
        showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  cubit.imagePicker(imageSource: ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  cubit.imagePicker(imageSource: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
      child: index == cubit.imageFiles.length
          ? Container(
              height: 100.w,
              width: 100.w,
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? Colors.grey[200]
                    : Colors.grey[200]!.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.add_a_photo_outlined,
                size: 35,
                color: theme.iconTheme.color!.withOpacity(.7),
              ),
            )
          : Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    cubit.imageFiles[index!],
                    width: 90.w,
                    height: 90.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () async => cubit.deletePickedImages(index!),
                    icon: Icon(Icons.delete_outline_outlined),
                  ),
                )
              ],
            ),
    );
  }
}
