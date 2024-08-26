// A class to describe a population of virtual organisms
// In this case, each organism is just an instance of a DNA object

import 'dart:math';

import 'package:num_remap/num_remap.dart';

import 'dna.dart';
import 'maths.dart';

class Population {
  Random rando = Random();
  static const int maxPhrases = 100;

  // Array to hold the current population
  List<DNA> population = [];
  // Array which we will use for our "mating pool"
  List<DNA> matingPool = [];
  int generations = 0; // Number of generations
  bool finished = false; // Are we finished evolving?
  String target = ''; // Target phrase
  double mutationRate = 0.01; // Mutation rate
  double perfectScore = 1.0;
  double worldrecord = 0.0;
  late List<String> genesPhrase;
  double maxFitness = 0.0;

  String best = '';

  Population();

  factory Population.create(
    String phrase,
    double mutationRate,
    int populationMax,
  ) {
    Population p = Population()
      ..target = phrase
      ..genesPhrase = phrase.split('')
      ..mutationRate = mutationRate
      ..population = List<DNA>.generate(
          populationMax, (int index) => DNA.create(phrase.length))
      ..calcFitness();

    return p;
  }

  /// Fill our fitness array with a value for every member of the population
  void calcFitness() {
    for (var dna in population) {
      dna.calcFitness(genesPhrase);
    }
  }

  /// Generate a mating pool (broken in favor of rejection sampling)
  void naturalSelectionPools() {
    // Clear the ArrayList
    matingPool.clear();

    double maxFitness = 0.0;

    for (var dna in population) {
      maxFitness = max(dna.fitness, maxFitness);
    }

    // Based on fitness, each member will get added to the mating pool a certain
    // number of times.
    // A higher fitness = more entries into mating pool = more likely to be
    // picked as a parent.
    // A lower fitness = fewer entries into mating pool = less likely to be
    // picked as a parent.

    // Basically construct probability wheel
    for (var i = 0; i < population.length; i++) {
      // Map a 'source' range into a 'destination' range.
      double fitness = population[i].fitness.remap(0, maxFitness, 0, 1);

      // Arbitrary multiplier, we can also use monte carlo method
      var n = (fitness * 100.0).floor();
      for (var j = 0; j < n; j++) {
        // and pick two random numbers
        matingPool.add(population[i]);
      }
    }
  }

  // Rejection sampling technique which eliminates probability pools.
  // NOTE: even though this uses less memory it is slower to converge.
  // The coding train has a follow up video that shows a faster yet simpler
  // way of picking items based on each item's probability.
  // https://www.youtube.com/watch?v=ETphJASzYes&list=PLRqwX-V7Uu6bJM3VgzjNV5YxVxUwzALHV&index=1&t=0s
  void naturalSelectionRejectionSampling() {
    maxFitness = 0.0;

    for (var dna in population) {
      maxFitness = max(dna.fitness, maxFitness);
    }
  }

  /// Create a new generation
  void generate() {
    // Start a new population to build. We don't want to place the new child
    // into the population that we are currently working with. The "incoming"
    // population must be a "source" only! Not both.
    List<DNA> newPopulation = [];

    // To use probability sampling the list must be sorted either accending    // or decending depending on whether the "fitness" is subtracted or
    // added in probabilitySampling(). Currently the sample method subtracts
    // which means "b" is sorted against "a".
    population.sort((a, b) => b.fitness.compareTo(a.fitness)); // decending
    // print(
    //     '${population[0].fitness}, ${population[population.length - 1].fitness}');

    for (var i = 0; i < population.length; i++) {
      DNA? partnerA = probabilitySampling();
      DNA? partnerB = probabilitySampling();

      DNA child = partnerA.crossover(partnerB);
      child.mutate(mutationRate);

      newPopulation.add(child);
    }

    // Switch to the new population.
    population = newPopulation;

    generations++;
  }

  // NOTE: This requires that the population is sorted prior.
  DNA probabilitySampling() {
    int index = 0;
    double r = rando.nextDouble();

    while (r > 0) {
      r -= population[index].fitness;
      index++;
    }

    index--;
    return population[index];
  }

  DNA acceptReject() {
    int degenerate = 0;
    while (true) {
      int index = Maths.randomRange(0, population.length);
      DNA partner = population[index];
      double r = Maths.randomRangeDouble(0.0, maxFitness);
      if (r < partner.fitness) {
        return partner;
      }

      degenerate++;

      if (degenerate > 10000) {
        return partner;
      }
    }
  }

  /// Compute the current "most fit" member of the population
  void evaluate() {
    worldrecord = 0.0;
    int index = 0;

    for (var i = 0; i < population.length; i++) {
      if (population[i].fitness > worldrecord) {
        index = i;
        worldrecord = population[i].fitness;
      }
    }

    best = population[index].phrase;
    finished = worldrecord >= perfectScore;
  }

  /// Compute average fitness for the population
  double get averageFitness {
    double total = 0.0;
    for (var dna in population) {
      total += dna.fitness;
    }
    return total / population.length;
  }

  List<String> get phraseSubset {
    List<String> lst = [];

    int displayLimit = min(population.length, maxPhrases);

    for (var i = 0; i < displayLimit; i++) {
      lst.add(population[i].phrase);
    }

    return lst;
  }

  String get allPhrases {
    String everything = "";

    int displayLimit = min(population.length, maxPhrases);

    for (var i = 0; i < displayLimit; i++) {
      everything += 'population[i].phrase\n';
    }
    return everything;
  }
}
