Rusiga
======

Ruby Simple Genetic Algorithm. This is a very simple and short implementation of a Genetic Algorithm in the Ruby language.

Requirements
------------

*   Ruby 1.9.3

Usage
-----

First, a fitness function should be defined. Rusiga is using this in order to evaluate each chromosome.

  def fitness_function(chrom)
      ...
  end
  
The input parameter "chrom" represents an individual. It is a binary array.

A population with GA-parameters is created as follows:

  # Rusiaga::Population.new(#_of_invids, 
  #                         chromosome_size, 
  #                         :fitness_function, 
  #                         tournament_size, 
  #                         crossover_probab,
  #                         mutation_probab)  
  pop = Rusiga::Population.new(300, 240, :fitness_function, 4, 0.5, 0.001)

