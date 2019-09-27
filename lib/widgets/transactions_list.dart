import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget{

final List<Transaction> transactions;
final Function deleteTx;
TransactionList(this.transactions,this.deleteTx);


@override
Widget build(BuildContext context) {

  return Container(
    width: double.infinity,
    height: 300,
    child: transactions.isEmpty?
     LayoutBuilder(builder:(ctx,constraints) {
       return Column(
         children: <Widget>[
           Text("No Transactions Added Yet", style:
           TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 20,
           ),
           ),
           SizedBox(height: 10,),
           Container(
             height: constraints.maxHeight*0.6,
             child: Image.asset(
               'assets/images/waiting.png', fit: BoxFit.cover,),),
         ],
       );
     }
  )


        :ListView.builder(
      itemBuilder: (context,index){
        return Card(
          color: Colors.deepOrange,
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
          child: ListTile(
          leading: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              border: Border.all(color:Colors.red),
              color: Colors.deepOrangeAccent,
              shape: BoxShape.circle

            ),
            child: Padding(
              padding: EdgeInsets.all(6),
              child:FittedBox(child:
              Text(
                  '₹${transactions[index].amount}',
                   style: TextStyle(color: Colors.white,fontSize: 3),
        ),
        ),
        ),
          ),
          title: Text(
            transactions[index].title,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white,),
          ),
          subtitle: Text(DateFormat('MMMM dd, yyyy').format(transactions[index].date),style: TextStyle(fontSize: 10
          ,fontWeight: FontWeight.bold),),
         trailing: MediaQuery.of(context).size.width>360?
         FlatButton.icon(
           icon: Icon(Icons.delete),
           label: Text('Delete'),
           onPressed: ()=>deleteTx(transactions[index].id),
           textColor: Colors.white,)

            :IconButton(icon: Icon(Icons.delete),color: Colors.white,
            onPressed: ()=>deleteTx(transactions[index].id),),
        ),
        );
      },
      itemCount: transactions.length,

  ),
  );
}
}
