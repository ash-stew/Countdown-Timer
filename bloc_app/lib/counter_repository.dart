class CounterRepository {
  // This function will return object of TensAndOnes
  TensAndOnes getTensAndOnes(int source) {
    int tens = 0;
    int ones = source % 10;

    tens = (source / 10).floor() * 10;

    // return an object of TensAndOnes
    return TensAndOnes(ones, tens);
  }
}

class TensAndOnes {
  final int ones;
  final int tens;

  // constructor
  TensAndOnes(this.ones, this.tens);
}
