/// All services can return either error or model
/// In order for us to validate this behaviour properly
/// without losing "context" of the repository
/// we can wrap our return value in the Handler. 
/// 
/// Error type is String but there is possibility
/// to create custom hanlders that can take error of the different type
/// The main thing to follow is the idea of
/// the implementation and usage of the class
class Handler<M> {
  Handler({
    this.error,
    this.model,
  });

  final String? error;
  final M? model;

  dynamic get value {
    if (error == null) {
      return model;
    } else {
      return error;
    }
  }
}
