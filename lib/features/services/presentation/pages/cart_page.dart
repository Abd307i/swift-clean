import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/notification/presentation/widgets/BuildNotificationWidget.dart';
import 'package:testing_firebase/features/services/presentation/bloc/cart_bloc.dart';
import 'package:testing_firebase/features/services/presentation/bloc/cart_event.dart';
import '../../dependency_injection.dart' as di;
import '../../domain/entites/service_entity.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/remove_from_cart.dart';
import '../bloc/cart_state.dart';

class CartScreen extends StatelessWidget{
  final String userId;

  const CartScreen(this.userId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CartBloc(
            addToCart: di.sl<AddToCart>(),
            removeFromCart: di.sl<RemoveFromCart>(),
            getCartItems: di.sl<GetCartItems>()
        )..add(LoadCartItems(userId)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Cart',
            style: TextStyle(
              color: Color(0xFF333E63),
              fontSize: 21,
              fontWeight: FontWeight.w500,
              fontFamily: 'Gilroy',
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: CartPage(userId: userId),
      ),
    );
  }

}

class CartPage extends StatelessWidget {
  final String userId;
  const CartPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context,state){
        if(state is CartError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message))
          );
        }
      },
      builder: (context, state){
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartLoaded) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: ListView.builder(itemCount: state.items.length
                        ,itemBuilder: (context,index) {
                          return buildNotificationWidget(
                              Icons.ac_unit_sharp,
                              state.items[index].itemName,
                              state.items[index].subPrice.toString(),
                              Colors.white,
                              Color(0xFF333E63),
                              Color(0xFF333E63));
                        })
                ),
              ]
          );
        }
        return const Center(child: Text('No Items available'));
      }
    );
  }
}