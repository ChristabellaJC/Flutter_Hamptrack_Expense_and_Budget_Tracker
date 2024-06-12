import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double maxProgress = 250000;
    double currentProgress = 25000;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 55, 15, 40),
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome Back",
                      style: TextStyle(fontSize: 20,
                      color: whiteColor,
                      shadows: [
                        Shadow(
                          blurRadius: 2,
                          color: strokeColor,
                        ),
                      ],
                      ),
                    ),
                    Text('Angela Chow',
                      style: TextStyle(
                        fontSize: 30,
                        color: whiteColor,
                        shadows: [
                          Shadow(
                            blurRadius: 2,
                            color: strokeColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),

                child: Column(
                  children: [
                    //STATS EXPENSE DAN INCOME
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 25)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 100,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(13),
                              ),

                              // BOX EXPENSE
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Expenses',
                                    style: TextStyle(
                                      color: primaryTextColor
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Rp',
                                        style: TextStyle(
                                          color: whiteColor
                                        ),
                                      ),
                                      Text('250.000',
                                      style: TextStyle(
                                          color: whiteColor
                                        ),
                                      ),
                                  ],)
                                ],
                              ),
                            ),
                            SizedBox(width: 30),
                            // BOX INCOME
                            Container(
                              width: 150,
                              height: 100,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Income',
                                    style: TextStyle(
                                      color: primaryTextColor
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Rp',
                                        style: TextStyle(
                                          color: whiteColor
                                        ),
                                      ),
                                      Text('250.000',
                                      style: TextStyle(
                                          color: whiteColor
                                        ),
                                      ),
                                  ],)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),

                    //Progress
                    Text('Budget',),
                    Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        width: double.infinity,
                        height: 20,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: primaryColor, width: 1),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        width: (currentProgress / maxProgress) *
                            MediaQuery.of(context).size.width,
                        height: 20,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "25.000",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "250.000",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //GAMBAR

                  //MOU

                  //DOING WELL

                  //GARIS

                  //HISTORY

                  //ROW JAN2024 - DES2024

                  //COLUMN
                    //CONTAINER
                      //ROW
                        //ICON EXPENSE OR INCOME
                        //COLUMN
                          //NOMINAL
                          //TANGGAL
                        //ICON HAPUS

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}