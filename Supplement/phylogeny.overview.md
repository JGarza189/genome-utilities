# Overview of Tree Building Methods

- **PHYLIP Neighbor Joining (NJ)**: This is a distance-based method that constructs a phylogenetic tree by progressively joining pairs of taxa that minimize the total branch length. It is fast and efficient but can be less accurate for complex evolutionary relationships.

- **MrBayes**: A Bayesian inference-based tool that uses Markov chain Monte Carlo (MCMC) to estimate phylogenetic trees by sampling from the posterior distribution of tree topologies. It provides probabilistic estimates of tree reliability but can be computationally intensive.

- **IQ-TREE**: A maximum-likelihood-based software that builds phylogenetic trees by optimizing the likelihood of sequence data under a chosen substitution model. It is highly efficient and includes model selection and bootstrap support for tree robustness.

- **FastTree**: A fast and approximate method for constructing phylogenetic trees using maximum likelihood estimation with a focus on speed. It is useful for large datasets but may sacrifice some accuracy compared to slower, more precise methods.

- **PhyML (Maximum Likelihood)**: A maximum likelihood-based method for constructing phylogenetic trees that estimates tree topologies by maximizing the likelihood of sequence data given a substitution model. It is widely used for its accuracy and statistical rigor in tree inference.

### Genetic Distance Models

### Jukes-Cantor (JC69)
A simple model assuming equal substitution rates for all nucleotides and equal base frequencies. It is best for closely related sequences with few substitutions.

### Kimura 2-Parameter (K2P)
Differentiates between transition and transversion rates while assuming constant rates within each category. It is useful for moderately divergent sequences where transitions occur more frequently.

### F84
An extension of the Kimura model that accounts for multiple substitutions at the same site and incorporates base frequencies. It is suitable for sequences with many substitutions and varying substitution rates.

### LogDet
A model that uses the logarithm of the determinant of the substitution matrix, handling highly divergent sequences without relying on specific substitution assumptions. It is ideal for deep evolutionary comparisons.

## Bootstrapping

Bootstrapping is a statistical method used to assess the reliability of phylogenetic trees by repeatedly resampling the data with replacement to generate multiple datasets. The resulting trees are compared to determine the consistency of branch support, typically expressed as bootstrap values indicating the percentage of times a particular clade is observed in the resampled trees.





## Nucleotide Ambiguity Codes

| Symbol 	|  Mnemonic     		| Translation             		|
| ------------	| --------------------------	| ---------------------------------	|
|   A	 	| 				| A (adenine)                      |
|   C	 	| 				| C (cytosine)                    	|
|   G	 	| 				| G (guanine)                     	|
|   T	 	|				| T (thymine)                      	|
|   U	 	| 				| U (uracil)	                      	|
|   R	 	| puRine			| A or G (purines)        	|
|   Y	 	| pYrimidine		| C or T/U (pyrimidines)  	|
|   M	 	| aMino group		| A or C                  		|
|   K	 	| Keto group		| G or T/U                		|
|   S	 	| Strong interaction	| C or G                  		|
|   W	 	| Weak interaction	|  A or T/U                		|
|   H	 	| not G			| A, C or T/U             		|
|   B	 	| not A			| C, G or T/U             		|
|   V	 	| not T/U			| A, C or G               		|
|   D	 	| not C			| A, G or T/U             		|
|   N	 	| aNy				| A, C, G or T/U		    	|

Johnson, A. D. (2010a). An extended IUPAC nomenclature code for polymorphic nucleic acids. *Bioinformatics, 26*(10), 1386–1389. [https://doi.org/10.1093/bioinformatics/btq098](https://doi.org/10.1093/bioinformatics/btq098)  