  import 'dart:typed_data';

  import 'package:flutter/material.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:image_picker/image_picker.dart';
  import 'package:lms/backend/book-enquires.dart';
  import 'package:lms/backend/image-upload.dart';
  import 'package:lms/const/custom-app-bar.dart';
  import 'package:lms/const/custom-button.dart';
  import 'package:lms/const/custom-textfield.dart';
  import 'package:lms/const/customAlertDialog.dart';
  import 'package:lms/const/overlays.dart';
  import 'package:lms/const/theme.dart';

  class AddBook extends StatefulWidget {
    const AddBook({super.key});

    @override
    State<AddBook> createState() => _AddBookState();
  }

  class _AddBookState extends State<AddBook> {
    Uint8List? _file;
    TextEditingController authourName = TextEditingController();
    TextEditingController bookName = TextEditingController();
    TextEditingController quantity = TextEditingController();
    TextEditingController price = TextEditingController();
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const CustomAppBar(
            title: 'Add Book',
            subtitle: 'Enjoy your days!!',
            screenIcon: FontAwesomeIcons.addressBook,
          ),
          backgroundColor: darkPrimaryColor.withOpacity(0.1),
          toolbarHeight: toolbarHeight,
        ),
        body: Container(
          color: darkPrimaryColor.withOpacity(0.1),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  child: CircleAvatar(
                    radius: 80,
                    child: _file == null
                        ? const Text('Upload Image')
                        : SizedBox(
                            width: 2 *
                                78, // 2 times radius - 1 (to accommodate the border)
                            height: 2 *
                                78, // 2 times radius - 1 (to accommodate the border)
                            child: ClipOval(
                              child: Image.memory(
                                _file!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  onTap: () async {
                    XFile? dipu = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (dipu != null) {
                      _file =
                          await StorageMethods().convertXFileToUint8List(dipu);
                    }
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: getWidth(context) * 0.9,
                    child: CustomTextField(
                        controller: authourName,
                        hintText: 'Authour Name',
                        alternateHintText: 'Enter authour name...',
                        labelText: 'Authour Name',
                        keyboardType: TextInputType.text)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: getWidth(context) * 0.9,
                    child: CustomTextField(
                        controller: bookName,
                        hintText: 'Book Name',
                        alternateHintText: 'Enter book name...',
                        labelText: 'Book Name',
                        keyboardType: TextInputType.text)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: getWidth(context) * 0.9,
                    child: CustomTextField(
                        controller: quantity,
                        hintText: 'Quantity',
                        alternateHintText: 'Enter quantity of book...',
                        labelText: 'Quantity',
                        keyboardType: TextInputType.number)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: getWidth(context) * 0.9,
                    child: CustomTextField(
                        controller: price,
                        hintText: 'Price',
                        alternateHintText: 'Enter price of book...',
                        labelText: 'Price',
                        keyboardType: TextInputType.number)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: getWidth(context) * 0.9,
                  child: CustomButton(
                      onPressed: () async {
                        // print('i am called ');
                        if (authourName.text.trim()== '') {
                          // ignore: use_build_context_synchronously
                          CustomAlertDialog().showAlertMyDialog(context,
                              'Ohhh no Error !!!', 'please enter author name');
                        
                        } else if (bookName.text.trim()== '') {
                          // ignore: use_build_context_synchronously
                          CustomAlertDialog().showAlertMyDialog(context,
                              'Ohhh no Error !!!', 'please enter book name');
                        }
                        else if (quantity.text.trim()== '') {
                          // ignore: use_build_context_synchronously
                          CustomAlertDialog().showAlertMyDialog(
                              // ignore: use_build_context_synchronously
                              context,
                              'Ohhh no Error !!!',
                              'please enter quantity of book');
                        
                        } else if (price.text.trim() == '') {
                          // ignore: use_build_context_synchronously
                          CustomAlertDialog().showAlertMyDialog(context,
                              'Ohhh no Error !!!', 'please enter book price');
                        } else if (_file ==null) {
                          // ignore: use_build_context_synchronously
                          CustomAlertDialog().showAlertMyDialog(context,
                              'Ohhh no Error !!!', 'please upload profile image');
                        }
                        else {
                          AnotherClass.showTransparentDialog(context);
                          //  AnotherClass.hideTransparentDialog(context);
                          // ignore: use_build_context_synchronously
                          String imageUrl =
                            await StorageMethods().uploadToStorage(_file!);
                          
                      String result=  await BookEnquires().addBook(
                              bookName.text,
                              authourName.text,
                              int.parse(price.text),
                              int.parse(quantity.text),
                              imageUrl);
                          print('i am testing here $result');
                        if(result!='Success'){
                          // ignore: use_build_context_synchronously
                           AnotherClass.hideTransparentDialog(context);
                          CustomAlertDialog().showAlertMyDialog(context,
                              'Soory', 'There may be some issue');
                        }else{
                          print('i am testing here $result');
                          // ignore: use_build_context_synchronously
                          AnotherClass.hideTransparentDialog(context);
                           CustomAlertDialog().showAlertMyDialog(context,
                              'Congart', 'Books are added');
                        }
                        
                      }
                      },
                      text: Text(
                        'Add Book',
                        style: buttonTextStyle,
                      )
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
