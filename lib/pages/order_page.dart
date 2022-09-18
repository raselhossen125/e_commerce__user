// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable

import 'package:e_commerce__user/provider/order_provider.dart';
import 'package:e_commerce__user/untils/constransts.dart';
import 'package:e_commerce__user/untils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  static const String routeName = '/order';

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).getOrdersByUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) => provider.orderList.isNotEmpty
            ? ListView.builder(
                itemCount: provider.orderList.length,
                itemBuilder: (context, index) {
                  final orderM = provider.orderList[index];
                  return ListTile(
                    title: Text(getFormatedDateTime(
                        orderM.dateModel.timestamp.toDate(),
                        'dd/MM/yyyy  hh:mm:ss a')),
                    subtitle: Text(orderM.orderStatus),
                    trailing:
                        Text('$currencySymbol${orderM.grandTotal.round()}'),
                  );
                },
              )
            : Center(
                child: Text('You have no orders yet'),
              ),
      ),
    );
  }
}
