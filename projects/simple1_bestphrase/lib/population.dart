// A class to describe a population of virtual organisms
// In this case, each organism is just an instance of a DNA object

import 'dart:math';

import 'package:num_remap/num_remap.dart';

import 'dna.dart';

class Population {
  Random rando = Random();

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

  /// Generate a mating pool
  void naturalSelection() {
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

  /// Create a new generation
  void generate() {
    // Refill the population with children from the mating pool
    int poolLength = matingPool.length;

    for (var i = 0; i < population.length; i++) {
      int a = rando.nextInt(poolLength);
      int b = rando.nextInt(poolLength);

      DNA partnerA = matingPool[a];
      DNA partnerB = matingPool[b];

      DNA child = partnerA.crossover(partnerB);
      child.mutate(mutationRate);

      population[i] = child;
    }

    generations++;
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
    finished = worldrecord == perfectScore;
  }

  /// Compute average fitness for the population
  // double getAverageFitness() {
  //   double total = 0.0;
  //   for (var dna in population) {
  //     total += dna.fitness;
  //   }
  //   return total / population.length;
  // }

  String get allPhrases {
    String everything = "";

    int displayLimit = min(population.length, 50);

    for (var i = 0; i < displayLimit; i++) {
      everything += 'population[i].phrase\n';
    }
    return everything;
  }
}
