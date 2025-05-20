abstract class OrderHistoryEvent{}

class GetOrderHistoryEvent extends OrderHistoryEvent{
  final String userId;
  GetOrderHistoryEvent(this.userId);
}

class GetOrderHistoryByUserType extends OrderHistoryEvent{
  final String userType;
  final String userId;
  final String status;
  GetOrderHistoryByUserType(this.userType,this.userId, this.status);
}