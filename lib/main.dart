import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SplitCostApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class SplitCostApp extends StatefulWidget {

  @override
  State<SplitCostApp> createState() => _SplitCostAppState();
}

class _SplitCostAppState extends State<SplitCostApp> {
  int _tipPercentage = 0;
  int _numberOfPeople = 1;
  double _cost = 0.0;
  double _splittedCost = 0.0;
  double _tip = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Split cost App", style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          )),
          backgroundColor: Colors.blue,
        ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 325,
                  height: 200,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Wprowadź kwotę rachunku',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10), 
                    ),
                    onChanged: (value) {
                      setState(() {
                        _cost = double.tryParse(value) ?? 0.0;
                        _calculateTip();
                        _couting();
                      });
                    },
                  ),
                ),
                Container(
                    width: 325,
                    height: 200,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        color: Colors.lightGreenAccent[100],
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Tyle Płaci każda osoba:", style: TextStyle(
                            fontSize: 23,
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                        )),
                        SizedBox(height: 15),
                        Text('${_couting().toStringAsFixed(2)} zł',
                            style: TextStyle(
                                fontSize: 38,
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                            )),
                        SizedBox(height: 4),
                      ],
                    )
                ),
                Container(
                    margin: EdgeInsets.only(top: 20.0),
                    width: 325,
                    height: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 2),
                        color: Colors.white
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15),
                            Icon(Icons.account_balance_wallet_rounded),
                            SizedBox(width: 15),
                            Text("Rachunek:", style: TextStyle(
                                color: Colors.black,
                                fontSize: 25
                            )),
                            SizedBox(width: 8),
                            Text('$_cost', style: TextStyle(
                                color: Colors.green,
                                fontSize: 25
                            ))
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15),
                            Icon(Icons.attach_money),
                            SizedBox(width: 5),
                            Text("Rachunek + tip:", style: TextStyle(
                                color: Colors.black,
                                fontSize: 25
                            )),
                            SizedBox(width: 8),
                            Text('${(_cost + _tip).toStringAsFixed(2)}', style: TextStyle(
                                color: Colors.green,
                                fontSize: 25
                            ))
                          ],
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            SizedBox(width: 5),
                            Text("Liczba osób", style: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                            )),
                            SizedBox(width: 50),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: decrement,
                            ),
                            SizedBox(width: 12),
                            Text('$_numberOfPeople',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20
                                )),
                            SizedBox(width: 12),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: increment,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            SizedBox(width: 5),
                            Text(
                                "Cały napiwek", style: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                            )),
                            SizedBox(width: 75),
                            Text('${_tip.toStringAsFixed(2)} zł',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20
                                )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            SizedBox(width: 5),
                            Text('$_tipPercentage %',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20
                                ))
                          ],
                        ),
                        SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Slider(
                              min: 0,
                              max: 100,
                              activeColor: Colors.green,
                              inactiveColor: Colors.lightGreenAccent,
                              divisions: 20,
                              value: _tipPercentage.toDouble(),
                              onChanged: (double value) {
                                setState(() {
                                  _tipPercentage = value.round();
                                  _calculateTip();
                                });
                              },
                            )
                          ],
                        )
                      ],
                    )
                ),
              ],
            ),
          )
  );
}

  void _calculateTip() {
    setState(() {
      if(_tipPercentage == 0)
      {
        _tipPercentage = 1;
      }
      _tip = (_cost * (_tipPercentage * 0.01));
      _splittedCost = (_cost + (_cost * (_tipPercentage * 0.01))) / _numberOfPeople ;
    });
  }

  double _couting() {
    return _splittedCost;
  }

  void increment() {
    setState(() {
      _numberOfPeople++;
      _calculateTip();
      _couting();
    });
  }

  void decrement() {
    setState(() {
      _numberOfPeople--;
      if(_numberOfPeople <= 0)
      {
        _numberOfPeople = 1;
      }
      _calculateTip();
      _couting();
    });
  }
}




