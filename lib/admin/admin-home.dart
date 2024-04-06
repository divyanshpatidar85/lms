import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lms/ScreenCommonBetweenAllUser/logout-class.dart';
import 'package:lms/admin/over-due-book-display.dart';
import 'package:lms/admin/return-book-by-user.dart';
// import 'package:lms/backend/AddandRemoveBookQuantity.dart';
import 'package:lms/backend/bookcatalog.dart';
// import 'package:lms/backend/getUserInformation.dart';
import 'package:lms/const/custom-app-bar.dart';
import 'package:lms/const/pi-chart.dart';
import 'package:lms/const/theme.dart';
import 'package:lms/student/student-home-screen.dart';

// ignore: must_be_immutable
class AdminHomeScreen extends StatefulWidget {
  List<dynamic>adminInfo;
   AdminHomeScreen({super.key,required this.adminInfo});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool hover=false;
  bool hover1=false;
  RxBool checking=true.obs;
  List? Data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    
  }
  void getData() async {
    Data = await BookCatalog().getCatalogData();
    if(Data!.isEmpty){
      print("data is shere $Data");
      Data=null;
    }
    
    checking.toggle();
    setState(() {
      
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const CustomAppBar(title: 'Home', subtitle: 'Hey Admin',screenIcon:FontAwesomeIcons.home,),
        backgroundColor:darkPrimaryColor.withOpacity(0.1),
        toolbarHeight:toolbarHeight,
      ),
      body:Container(
        color:darkPrimaryColor.withOpacity(0.1),
        width:getWidth(context),
        height:double.infinity,
        child:SingleChildScrollView(
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:20.0,left:8,right:8),
                child: Stack(
                  children:[
                    Container(
                      height:320,
                      // color:white,
                      width:getWidth(context)*0.9,
                      decoration:BoxDecoration(
                            color:white,
                            border:Border.all(color:red),
                            borderRadius:BorderRadius.circular(6)
                          ),
                      child: Column(
                        children: [
                          const SizedBox(height:10,),
                          CircleAvatar(
                            radius:70,
                            child:SizedBox(
                          width: 2 *
                              65, // 2 times radius - 1 (to accommodate the border)
                          height: 2 *
                              65, // 2 times radius - 1 (to accommodate the border)
                          child: ClipOval(
                            // child: Image.network(widget.adminInfo[5].toString(),
                            //   fit: BoxFit.cover,
                            //   scale:0.5,
                            child:FadeInImage(
                                          placeholder:const AssetImage(
                                              'assets/app-logo/lmslogog.png'), // Placeholder image
                                          image: NetworkImage(widget.adminInfo[5]), // Actual profile image
                                          fit: BoxFit
                                              .cover, // Adjust image to fit circle avatar
                                        ) ,
                            ),
                          ),
                        ),
                          
                         const SizedBox(height:10,),
                         customTitle(context,'Admin Information'),
                         const SizedBox(height:10,),
                          customRowForLableAndValue(labelName: 'Admin Name', labelValue:widget.adminInfo[1].toString(),),
                          customRowForLableAndValue(labelName: 'Admin id', labelValue:widget.adminInfo[2].toString(),),
                          customRowForLableAndValue(labelName: 'Mobile Number', labelValue:widget.adminInfo[6].toString(),),
                
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //analtyics code bagin from here
              Padding(
                padding: const EdgeInsets.only(top:14.0,left:8,right:8),
                child: Stack(
                  children:[
                    Obx(() => Container(
                      height:200,
                      // color:white,
                      width:getWidth(context)*0.9,
                      decoration:BoxDecoration(
                            color:white,
                            border:Border.all(color:red),
                            borderRadius:BorderRadius.circular(6)
                          ),
                      child:!checking.value==true&&Data!=null?PiChart(issueBook:Data![0]+0.0, noissuebook:Data![1]+0.0):Center(child:Text("No Date is here",style:subHeadingStyle,),),
                    ),
                    )
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(top:14.0,left:8,right:8),
                child: Stack(
                  children:[
                    Container(
                      height:100,
                      // color:white,
                      width:getWidth(context)*0.9,
                      decoration:BoxDecoration(
                            color:white,
                            border:Border.all(color:red),
                            borderRadius:BorderRadius.circular(6)
                          ),
                      child: SingleChildScrollView(
                        scrollDirection:Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              
                              InkWell(
                                child: Card(
                                  color:hover?darkPrimaryColor.withOpacity(0.01):white,
                                  child: SizedBox(
                                    height:80,
                                    width:150,
                                    child:Center(
                                      child: Text('Return Book',style:headingStyle(context),)
                                      ),
                                  ),
                                ),
                                onTap:()async{
                                  hover=true;
                                //  List<dynamic>userInfo= await GetUserInformation().getInfoOfCurrentUser();
                                //  Navigator.push(context,MaterialPageRoute(builder:(BuildContext)));
                                // ignore: use_build_context_synchronously
                                // Navigator.push(context,MaterialPageRoute(builder:));
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const ReturnBookByUser()));
                                  
                                  setState(() {
                                    
                                  });
                                    Future.delayed(const Duration(milliseconds:100)).whenComplete((){
                                         hover=false;
                                  setState(() {
                                    
                                  });
                                    });
                                 
                                },
                              ),
                               InkWell(
                                child: Card(
                                  color:hover1?darkPrimaryColor.withOpacity(0.01):white,
                                  child: SizedBox(
                                    height:80,
                                    width:150,
                                    child: Center(
                                      child:Text('Overdue Book',style:headingStyle(context)),
                                    ),
                                    
                                  ),
                                ),
                                onTap:()async{
                                  hover1=true;
                                  Navigator.push( context,
                                  MaterialPageRoute(
                                    builder:(context)=>const OverDueBookDisplay()
                                    )
                                    );
                                  setState(() {
                                    
                                  });
                                    Future.delayed(Duration(milliseconds:100)).whenComplete((){
                                         hover1=false;
                                  setState(() {
                                    
                                  });
                                    });
                                 
                                },
                              ),
                                          
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0,left:8,right:8),
                child:LogOutUniversal().logOut(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
   Padding customTitle(BuildContext context,String title) {
    return Padding(
                        padding:const EdgeInsets.all(8.0),
                        child:Center(
                          child:Text(title,style:headingStyle(context),),
                        ),
                        );
  }
}