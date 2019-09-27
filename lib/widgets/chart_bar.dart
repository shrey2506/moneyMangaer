import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget{
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label,this.spendingAmount,this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(children: <Widget>[

        Container(
          height: constraint.maxHeight*0.08,
          child: FittedBox(child: Text('₹${spendingAmount.toStringAsFixed(0)}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 3),),),),
        SizedBox(height: constraint.maxHeight*0.05,),
        Container(
          height: constraint.maxHeight*0.7,
          width: 25,
          child: Stack(
            alignment: Alignment(0.0, 1.0),
            children: <Widget>[
              Container(decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrangeAccent, width: 1.0),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              ),
              FractionallySizedBox(heightFactor: spendingPctOfTotal,
                child: Container(
                    decoration: BoxDecoration(color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(20),)
                ),),
            ],
          ),
        ),
        SizedBox(height: constraint.maxHeight*0.05,),
        Container(
          height: constraint.maxHeight*0.08,
          child:FittedBox(
          child:Text(label, style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 15),
          ),
        ),
        ),

      ],

      );
    },);
  }
}