import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:money_manager_app/widgets/transactions_list.dart';
import './widgets/new_transactions.dart';
import './model/transaction.dart';
import './widgets/chart.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      title: 'Money Manager',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState()=>_MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [

  ];
  bool _showCart=false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }
  void _addNewTransaction(String title, double amount,DateTime choosenDate) {
    final newtx = Transaction(
        title: title,
        amount: amount,
        date: choosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newtx);
    });
  }
    void _startAddNewTransaction(BuildContext ctx) {
      showModalBottomSheet(
          context: ctx, builder: (_) {
        return GestureDetector(

          onTap:(){} ,
            child:NewTransactions(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
        );
      });
    }

    void deleteTransactions(String id){
         setState(() {
           _userTransactions.removeWhere((tx){
             return tx.id==id;
           });
         });
    }

    @override
    Widget build(BuildContext context) {
    final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
      final appBar= AppBar(
        title: Text(
          'Money Manager', style: TextStyle(fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add_box), color: Colors.white,
            onPressed: ()=>_startAddNewTransaction(context),
          )
        ],

      );
      final txList= Container(
      height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.80,
      child:TransactionList(_userTransactions,deleteTransactions),
      );

      return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
               if(isLandscape) Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Text('Show Chart'),
                  Switch.adaptive(
                    value: _showCart,
                    activeColor: Colors.deepOrange,
                    onChanged:(val){
                      setState(() {
                        _showCart=val;
                      });
                    } ,),
                ],),
               if(!isLandscape)Container(
                 height: (
                     MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
                 child:Chart(_recentTransactions),
               ),

             if (!isLandscape) txList,
               if (isLandscape) _showCart?Container(
                 height: (
                     MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.6,
                 child:Chart(_recentTransactions),
               )
       :txList
      ],
      )

        ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         floatingActionButton:Platform.isIOS?Container(): FloatingActionButton(
          child: Icon(Icons.add_circle, color: Colors.white,),
          hoverElevation: 10,
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: ()=>_startAddNewTransaction(context) ,
        ),
      );
    }
  }

