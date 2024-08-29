import 'dart:math';

class DNA {
  // The genetic sequence
  // DNA is random floating point values between 0 and 1 (!!)
  List<double> genes = [];

  DNA();

  factory DNA.create(int seed, Random rando) {
    DNA dna = DNA()..genes.add(rando.nextDouble());

    return dna;
  }

  DNA copy(Random rando) {
    // It gets made with random DNA
    var newDNA = DNA.create(2345, rando);
    // But then it is overwritten
    newDNA.genes[0] = genes[0];
    return newDNA;
  }

// Based on a mutation probability, picks a new random value in array spots
  mutate(mutationRate, Random rando) {
    for (var i = 0; i < genes.length; i++) {
      if (rando.nextDouble() < mutationRate) {
        genes[i] = rando.nextDouble();
      }
    }
  }
}
