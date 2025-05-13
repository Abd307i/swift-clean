abstract class ServiceEvent{}

class LoadServices extends ServiceEvent{}

class LoadItemsByService extends ServiceEvent{
  final String serviceId;
  LoadItemsByService(this.serviceId);
}