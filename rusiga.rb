module Rusiga
  module Crossover
    def self.uniform(invid1, invid2, p_c) 
      # iniform recombination with p_c recombination probability
      chromosome_size = invid1.chrom.size-1
      child = Individual.new
      for idx in 0..chromosome_size do 
        if rand(0.0..1.0) <= p_c then
          child.chrom << invid1.chrom[idx]
        else
          child.chrom << invid2.chrom[idx]
        end
      end
      return child
    end # uniform
  end # module GA

  module Selection
    def self.tournament(population, tsz)
      # tournament selection with t_s tournament size
      tour = Array.new
      tsz.times do # select tsz random individuals
        tour << rand(0..population.size_p-1)
      end
      tour.sort! { |a,b| population.individuals[b].fitness <=> population.individuals[a].fitness }
      return population.individuals[tour[0]] # fittest individual in the tournament
    end
  end # module

  class Individual
    attr_accessor :chrom   # value of the chromosome  
    attr_accessor :fitness # fitness value
    def initialize()
      @chrom = Array.new
    end
    def randomize(size)
      @chrom = Array.new
      size.times do
        @chrom << rand(0..1)
      end
    end
    def mutate(p_m)
      # with p_m mutation probability
      @chrom.each do |bit|
        if rand(0.0..1.0) <= p_m then
          bit == '0' ? bit = '1' : bit = '0'
        end
      end
    end
  end
  
  class Population
    attr_accessor :individuals, :size_p, :size_i, :ff, :p_s, :p_c, :p_m
    def initialize(size_p, size_i, fitness_function, p_selection, p_crossover, p_mutation)
      # create a population with size_p individuals of size_i 
      @individuals = Array.new; @size_p = size_p; @size_i = size_i
      @ff = method(fitness_function); @p_s = p_selection; @p_c = p_crossover; @p_m = p_mutation
      @size_p.times do
        invid = Individual.new; invid.randomize(@size_i)
        invid.fitness = @ff.call(invid.chrom)
        @individuals << invid
      end
      @individuals.sort! { |a,b| b.fitness <=> a.fitness }
    end # initialize
    def generation()
      children = Array.new
      @size_p.times do 
        parent1 = Selection::tournament(self, @p_s)
        parent2 = Selection::tournament(self, @p_s)
        child = Crossover::uniform(parent1, parent2, @p_c)
        child.fitness = @ff.call(child.chrom)
        children << child
      end
      @individuals.each { |i| children << i }
      children.sort! { |a,b| b.fitness <=> a.fitness }
      @individuals = children[0..@size_p-1]
    end # generation
  end

  module PopulationOutput
    def self.screen(population)
      population.individuals.each do |i|
        print "#{i.fitness} " 
      end
      puts
    end # self.screen
  end # module

end # module Rusiga





