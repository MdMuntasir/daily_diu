abstract class UseCase<Type,Param> {
  Future<Type> call({Param para});
}