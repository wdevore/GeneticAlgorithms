# simple1_bestphrase

Figures out a phase using GAs.

The genetic information (DNA) is a sequence of characters, for example, "Unijorm" has 7 genetic pieces of information.

Without *mutation* and The initial population must contain every gene. The genes are not required to be present in a single *element*. The genes could be dispersed amongst the population. If the population is to small the probability of genes being present decreases. If a gene is missing then the algorithm will never converge.

## Steps
- Setup
  - Render
- Selection
- Reproduction
  - Pick parents
  - Crossover
  - Mutation
  - Add new child to a new population
- Replace old population with new population and loop back to Selection

## Algorithm
- Outer loop: **Setup** Create a population of N elements with random genetic material. (Chromosomes). We should have *variation* within the population.
- Inner loop: typically a render function
  - Calculate *fitness* for every member of the population for use during *selection*. The fitness score is typically used as a probability factor.
    - Reproduction/Relection N - loop
      - Pick N parents that will be *mixed*. We use *probability* rather the *best-fit*. This minimizes domination.
      - Make new element from picked parents.
        - Crossover. Pick a crossover position. This position doesn't always need to be constant.
        - Mutation. Mutation *rate* is generally very low, for example, 1%.

The Inner loop's goal is to create a **new** population.

## GUI
Show
- Current element with highest fitness of the population
- Total generations
- Average fitness
- Total population
- Mutation rate
- Scrolling list of generations
