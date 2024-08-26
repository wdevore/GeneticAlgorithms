import 'dart:math';

/// A class to describe a pseudo-DNA, i.e. genotype
///
/// Here, a virtual organism's DNA is an array of character.
///
/// Functionality:
/// - convert DNA into a string
/// - calculate DNA's "fitness"
/// - mate DNA with another set of DNA
/// - mutate DNA
class DNA {
  Random rando = Random();

  late List<String> genes;
  double fitness = 0.0;

  DNA();

  /// Constructor (makes a random DNA)
  factory DNA.create(int length) {
    DNA dna = DNA();
    // The genetic sequence
    dna.fitness = 0.0;

    dna.genes =
        List<String>.generate(length, (int index) => dna.generateChar());

    return dna;
  }

  factory DNA.createBlank(int length) {
    DNA dna = DNA();
    // The genetic sequence
    dna.fitness = 0.0;

    dna.genes = List<String>.filled(length, '');

    return dna;
  }

  String generateChar() {
    // The original range from p5.js was (63, 122)
    // I expanded it to include numbers and symbols.
    var c = randomRange(31, 127);

    // if (c == 63) {
    //   c = 32;
    // } else if (c == 64) {
    //   c = 46;
    // }

    return String.fromCharCode(c);
  }

  /// number is between: '>= [from]' but '< [to]'
  int randomRange(int from, int to) {
    int ran = rando.nextInt(to - from) + from;
    return ran;
  }

  /// Converts character array to a String
  String get phrase => genes.join();

  /// Fitness function (returns floating point % of "correct" characters)
  void calcFitness(List<String> genesPhrase) {
    int score = 0;
    for (var i = 0; i < genesPhrase.length; i++) {
      if (genes[i] == genesPhrase[i]) {
        score++;
      }
    }
    fitness = score / genesPhrase.length;
  }

  /// Crossover returns a 'mix' between the [partner] DNA and this DNA.
  DNA crossover(DNA partner) {
    // A new child
    DNA child = DNA.createBlank(genes.length);

    int midpoint = rando.nextInt(genes.length); // Pick a midpoint

    // Half from one, half from the other
    for (var i = 0; i < genes.length; i++) {
      if (i > midpoint) {
        child.genes[i] = genes[i];
      } else {
        child.genes[i] = partner.genes[i];
      }
    }
    return child;
  }

  /// Based on a mutation probability, picks a new random character
  void mutate(mutationRate) {
    for (var i = 0; i < genes.length; i++) {
      if (rando.nextDouble() < mutationRate) {
        genes[i] = generateChar();
      }
    }
  }
}
