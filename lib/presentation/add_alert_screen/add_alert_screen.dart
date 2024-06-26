// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_test_designli/core/go_router.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/core/stocks_symbol_enum.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc_trades_real_time/trades_real_time_bloc.dart';

class AddAlertScreen extends StatelessWidget {
  const AddAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TradesRealTimeBloc>().add(TradesRealTimeTriggerEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Alert',
          style:
              Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 25),
        ),
        backgroundColor: MyColors.designlyOrange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(Navigation.homeScreen.name),
        ),
      ),
      backgroundColor: MyColors.designlyDarkBlue,
      body: const Column(
        children: [Expanded(child: StockAlertForm())],
      ),
    );
  }
}

class StockAlertForm extends StatefulWidget {
  const StockAlertForm({super.key});
  @override
  StockAlertFormState createState() => StockAlertFormState();
}

class StockAlertFormState extends State<StockAlertForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedStock;
  double? _alertPrice;

  final List<String> _stocks = [
    StocksSymbol.apple.symbol,
    StocksSymbol.binance.symbol,
  ];

  void _showAlert() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Stock Alert'),
            content: Text(
              'Set alert for $_selectedStock at \$${_alertPrice?.toStringAsFixed(2)}?',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Confirm'),
                onPressed: () {
                  BlocProvider.of<TradesRealTimeBloc>(context).add(
                    SetAlertEvent(
                      symbol: _selectedStock!,
                      alertPrice: _alertPrice!,
                    ),
                  );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Alert set successfully!')),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TradesRealTimeBloc, TradesRealTimeState>(
      listener: (context, state) {
        if (state is AlertTriggeredState) {
          final symbol = state.symbol;
          final alertPrice = state.alertPrice;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 5),
              content: Text(
                'Your alert for the $symbol stock has reached $alertPrice',
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Set Stock Alert'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  value: _selectedStock,
                  decoration: const InputDecoration(labelText: 'Select Stock'),
                  items: _stocks.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedStock = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a stock';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Alert Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an alert price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _alertPrice = double.parse(value!);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.designlyOrange,
                  ),
                  onPressed: _showAlert,
                  child: const Text(
                    style: TextStyle(color: MyColors.designlyDarkBlue),
                    'Set Alert',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
