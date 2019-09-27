import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;
  NewTransactions(this.addTx);
  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions>
{
  final titleController=TextEditingController();
  final amountController=TextEditingController();
  DateTime _selectDate;

  void _submitData(){
    final enteredTitle=titleController.text;
    final enteredAmount=double.parse(amountController.text);

    if(enteredTitle.isEmpty|| enteredAmount<=0|| _selectDate==null){
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );
    Navigator.of((context)).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate==null){
        return;
      }
      setState(() {
        _selectDate=pickedDate;
      });


    });
  }

  @override
  Widget build(BuildContext context){
    return  SingleChildScrollView(
      child:Card (
      elevation: 5,
      child:Container(
        padding: EdgeInsets.only(top:10,left: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom+10),
        child: Column(children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
            onSubmitted:(_)=>_submitData() ,
          ),
          TextField(decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted:(_)=>_submitData() ,

          ),
          Container(
            height: 70,
            child:Row(children: <Widget>[
             Expanded(child:
            Text(_selectDate==null ?'No Date Chosen'
                :'Picked Date: ${DateFormat('MMMM dd, yyyy').format(_selectDate)}'),),


            FlatButton(
              textColor: Colors.deepOrangeAccent,
              child: Text('Choose Date' ,style: TextStyle(fontWeight: FontWeight.bold),),
                onPressed: _presentDatePicker)
          ],),),

          RaisedButton(child: Text("Add Transaction"),
            color: Colors.deepOrange,
            onPressed: _submitData ,
            textColor: Colors.white,
          )
        ],
        ),
      ),
    ),
    );
  }
}