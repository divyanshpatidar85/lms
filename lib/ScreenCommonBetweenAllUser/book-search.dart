
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms/ScreenCommonBetweenAllUser/displayed-book-info.dart';
import 'package:lms/backend/get-book-equires.dart';
import 'package:lms/const/theme.dart';

class BookSearch extends StatefulWidget {
  final String userType;
 
   BookSearch({super.key, required this.userType});

  @override
  State<BookSearch> createState() => _BookSearchState();
}

class _BookSearchState extends State<BookSearch> {
  List<Map<String, dynamic>>?list;
  TextEditingController seachController=TextEditingController();
  @override
  void initState(){
    super.initState();
    getAllBookLms();
     Timer.periodic(const Duration(seconds:3), (Timer t) {
    getAllBookLms();
  });
    
  }
  void getAllBookLms()async{
   list=await GetAllBookInfo().getBooks();
   setState(() {
     
   });
  }

void searchBook(String bookName) async{
 list=await GetAllBookInfo().searchBook(bookName);
   if(bookName.isEmpty){
    getAllBookLms();
   }
    setState(() {
     
   });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: toolbarHeight,
        backgroundColor: darkPrimaryColor.withOpacity(0.1),
        elevation:0,
        titleSpacing: 0,
        title: SizedBox(
          height: toolbarHeight,
         
          child:Stack(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: const BoxDecoration(
                  color: red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(
                        20, 20), 
                    bottomRight: Radius.elliptical(
                        20, 20),
                  ),
                ),
              ),
              Positioned(
                top: -10,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50,left:20,right:20),
                  child: Container(
                    width: 10,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.elliptical(20, 30),
                        bottomRight: Radius.elliptical(20, 30),
                        topRight: Radius.elliptical(20, 30),
                        topLeft: Radius.elliptical(20, 30),
                      ),
                      color: white,
                      border: Border.all(color: red),
                    ),
                    child: TextField(
                      controller:seachController,
                      decoration:const InputDecoration(
                        prefixIcon:Icon(Icons.search,color:red,size:25,),
                        border:InputBorder.none,
                        hintText:'Search book'
                      ),
                      onChanged:(val){
                        searchBook(val);
                      },
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body:list!=null?Container(
        color:darkPrimaryColor.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children:[
              ListView.builder(
                itemBuilder:(BuildContext context, index) =>Column(
                  children: [
                    DisplayedBookIndormation(bookName:list![index]['bookname'],
                     bookAuthor:list![index]['bookauthor'], 
                     bookquantity:list![index]['quantity'],
                     userType:widget.userType,
                      bookImageUrl:list![index]['imageurl'],
                      bookid:list![index]['bookid'],
                      ),
                    Container(
                      height:10,
                      width:double.infinity,
                      color: darkPrimaryColor.withOpacity(0.01),
                    )
                  ],
                ),
                itemCount:list!.length,)
            ],
          ),
        ),
      ):Container(
        color:darkPrimaryColor.withOpacity(0.1),
        child: const Center(
          child:  CircularProgressIndicator(
            color:red,
          ),
        ),
      ),
    );
  }
}
