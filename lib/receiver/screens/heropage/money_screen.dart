import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MoneyScreen extends StatefulWidget{
  const MoneyScreen({super.key});

  @override
  State<StatefulWidget> createState()=>MoneyScreenState();

}

class MoneyScreenState extends State<MoneyScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      color: Colors.pink,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                SizedBox(height: 10.h,),

                //appbar dynamic Create
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Icon(Icons.location_on,size: 25.sp,color: Colors.pink,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("Sadar",style: TextStyle(fontWeight: FontWeight.bold),),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 5.w),
                              child: FaIcon(FontAwesomeIcons.angleDown,size: 15.sp,),
                            ),
                          ],
                        ),
                        const Text("Rajkot")
                      ],),const Spacer(),

                    Container(
                      height: 30.h,width: 30.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey[300]!)
                      ),
                      child:  const Center(child: Icon(Icons.g_translate)),
                    ),
                    SizedBox(width: 5.w,),
                    GestureDetector(
                      onTap: (){
                      },
                      child: SizedBox(
                        height: 30.h,width: 30.w,
                        child: const CircleAvatar(
                          backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiaLO5Z4Ga_OJMvDSNnn2b_UT6iMUvWU2Btg&usqp=CAU",),
                        ),
                      ),
                    )
                  ],),
                ),
                SizedBox(height: 20.h,),
                SizedBox(
                  height: 150.h,width: 150.w,
                  child: Image.asset("assets/images/ic_wallet.png",fit: BoxFit.fill,),
                ),
                SizedBox(height: 10.h,),
                Text("Edition Wallet",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold),),
                const Text("Seamless one-click checkout for all payments on Zomato"),
                SizedBox(height: 10.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: WidgetStateProperty.all(0),
                              padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 15.h))
                          ),
                          onPressed: (){}, child: Text("Activate Wallet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp),))),
                ),
                Container(
                  height: 10.h,
                  color: Colors.grey[300]!,
                ),
                SizedBox(height: 20.h,),
                ListTile(
                  leading: SizedBox(
                      height: 70.h,width: 50.w,
                      child: Image.asset("assets/images/ic_checkout.png",fit: BoxFit.fill,)),
                  title: const Text("One-click checkout",style: TextStyle(fontWeight: FontWeight.w500),),
                  subtitle: Text("No need to wait for OTPs-paymentts get processed instantly",style: TextStyle(fontSize: 10.sp),),
                ),
                const Divider(),
                ListTile(
                  leading: SizedBox(
                      height: 70.h,width: 50.w,
                      child: Image.asset("assets/images/ic_safe.png",fit: BoxFit.fill,)),
                  title: const Text("Safe and secure",style: TextStyle(fontWeight: FontWeight.w500),),
                  subtitle: Text("Stay protexted with bank-grade security while making payments",style: TextStyle(fontSize: 10.sp),),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }

}