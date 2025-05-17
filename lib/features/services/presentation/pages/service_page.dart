import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/notification/presentation/widgets/BuildNotificationWidget.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_items_by_service.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_services.dart';
import 'package:testing_firebase/features/services/presentation/pages/cart_page.dart';
import '../../dependency_injection.dart' as di;
import '../../domain/entites/service_entity.dart';
import '../bloc/service_bloc.dart';
import '../bloc/service_event.dart';
import '../bloc/service_state.dart';
import 'items_page.dart';


class ServicesPage extends StatelessWidget {
  final String userId;

  const ServicesPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ServiceBloc(
        getServices: di.sl<GetServices>(),
        getItemByService: di.sl<GetItemByService>())..add(LoadServices()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xF5F6FA),
          title: Text('Services',
          style: TextStyle(color: Color(0xFF333E63))
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: Color(0xFF333E63)),
            onPressed:() {
            Navigator.pop(context);
          },),
          actions: [
            IconButton(onPressed:() {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()
            )
            );
            },icon: Icon(Icons.shopping_cart,color: Color(0xFF333E63)))

          ],
        )
        ,
        body: ServicesGridView(userId: userId,),
        ),
    );
  }
}

class ServicesGridView extends StatelessWidget {
  final String userId;
  const ServicesGridView({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceBloc, ServiceState>(
      listener: (context, state) {
        if (state is ServiceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ServiceLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ServiceLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(itemCount: state.services.length
                    ,itemBuilder: (context,index) {

                  return InkWell(
                      child: buildNotificationWidget(
                      Icons.ac_unit_sharp,
                      state.services[index].name,
                      state.services[index].description,
                      Colors.white,
                      Color(0xFF333E63),
                      Color(0xFF333E63)
                  ),onTap: () =>
                      //_navigateToItemsPage(context,state.services[index])
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ItemsPage(userId,state.services[index].id,state.services[index].name)))
                  );

                  /*return buildNotificationWidget(
                        Icons.ac_unit_sharp,
                        state.services[index].name,
                        state.services[index].description,
                        Colors.white,
                        Color(0xFF333E63),
                        Color(0xFF333E63)
                        );*/
                      }
                      )
                    )
                ]
          );
        }
        return const Center(child: Text('No services available'));
      },
    );
  }

}

class ServiceCard extends StatelessWidget {
  final ServiceEntity service;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.service,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: service.imgUrl != null
                      ? Image.network(
                    service.imgUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.error),
                  )
                      : const Icon(Icons.category, size: 60)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                    Text(
                      service.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}