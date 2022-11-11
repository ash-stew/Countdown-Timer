class Ticker {

  // ticker is the data source for the timer application. It will expose stream of ticks which we subscribe and react to
  // it will take the number of ticks (i.e seconds) and returns a stream which emits the remaining seconds each seconds
  
  Stream<int> tick({int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
