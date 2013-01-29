Rusiga
======

Ruby Simple Genetic Algorithm. This is a very simple and short implementation of a Genetic Algorithm in the Ruby language.

Genetic Algorithms
------------------

Genetic algorithms are sophisticated search-/optimization techniques, loosely related to the mechanisms of natural evolution which is based upon reproduction and selection. The parameters of an optimization problem can be encoded as a binary string, the so-called chromosome. Each chromosome represents one individual in a pool of solutions, called a population. During reproduction, pairs of individuals are selected for recombination and some parts of their chromosomes form a new individual. This is termed crossover and controlled by the crossover probability. After recombination, individual bits of the new chromosome are mutated according to a low mutation probability. The resulting new individuals are assessed with the fitness function. This measures how well an individual solves the original problem. Fitter individuals have a higher chance to reproduce. This is controlled by the so-called selection operator. The fittest individuals remain in the population and build the basis for the next generation.This process is repeated over a number of generations, and it can be represented by the following pseudo code with P0, P1, P2, and P3 representing populations of possible solutions:

    begin GA
        P0 = fittest( initialize(P0) );
        while NOT break_condition do begin
            P1 = selection(P0);
            P2 = recombination(P1);
            P3 = mutation(P2);
            P0 = fittest(P3, P0)
        end
    end

Rusiga uses very rudimentary operators that are easy to implement. These are summarized in the following. Recombination is split up into two steps, selecting the individuals for recombination, and performing the actual recombination. 
Both steps can be realized through distinct GA operators. In RuSiGA, two indivduals are selected for recombination based on tournament selection. This selects a number of individuals from the population randomly, and returns the fittest in this tournament. The number is determined by the tournament size. The actual recombination is done according to the uniform crossover operator. It determines for every crossover location (every bit in the chromosome) according to the crossover probability whether the value for the new individual (offspring) is taken from the first or from the second parent. If this probability is set to 0.5, the offspring will be comprised of approximately half of the traits from each parent.

Most other GA-parameters depend on the complexity of the particular problem size to be solved. The population size should be set to a high value reflecting the complexity of the sampling in the search space. Tournament size should be set to a value that corresponds to the problem size as well. It is important to note that high tournament sizes lead to elitist selection, with a potential premature convergence of the search into a local optimum. Lower numbers result in lower selection pressure. RuSiGA maintains and evolves the fittest individuals found in the population (i.e. it solves maximization problems) probability may be set to 0.5, mutation probability should be adjusted to a low value (e.g. 0.001).


Requirements
------------

*   Ruby 1.9.3

Usage
-----

First, a fitness function should be defined. Rusiga is using this in order to evaluate each chromosome.

    def fitness_function(chrom)
        ...
    end
  
The input parameter "chrom" represents an individual. It is a binary array. In order to being able to retrieve useful fitness values, the fitness function should first perform a so-called genotype-phenotype transfer and then do whatever is necessary to retrieve a fitness value, e.g.

    def fitness_function(chrom)
        # genotype-phenotype transfer
        phenotype1 = chrom[0..99]
        phenotype2 = chrom[100..199]
        phenotype2 = chrom[200..299]
        # calculate fitness
        fitness = (penotype1 + phenotype2) / phenotype3
        return fitness
    end

A population with GA-parameters is created as follows:

    # Rusiaga::Population.new(#_of_invids, 
    #                         chromosome_size, 
    #                         :fitness_function, 
    #                         tournament_size, 
    #                         crossover_probab,
    #                         mutation_probab)  
    pop = Rusiga::Population.new(300, 240, :fitness_function, 4, 0.5, 0.001)

