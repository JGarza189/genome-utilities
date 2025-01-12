# Genetic Distance Models Overview

## Jukes-Cantor (JC69)
A simple model assuming equal substitution rates for all nucleotides and equal base frequencies. It is best for closely related sequences with few substitutions.

## Kimura 2-Parameter (K2P)
Differentiates between transition and transversion rates while assuming constant rates within each category. It is useful for moderately divergent sequences where transitions occur more frequently.

## F84
An extension of the Kimura model that accounts for multiple substitutions at the same site and incorporates base frequencies. It is suitable for sequences with many substitutions and varying substitution rates.

## LogDet
A model that uses the logarithm of the determinant of the substitution matrix, handling highly divergent sequences without relying on specific substitution assumptions. It is ideal for deep evolutionary comparisons.

# Bootstrapping 




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

### Citation
Johnson, A. D. (2010a). An extended IUPAC nomenclature code for polymorphic nucleic acids. *Bioinformatics, 26*(10), 1386–1389. [https://doi.org/10.1093/bioinformatics/btq098](https://doi.org/10.1093/bioinformatics/btq098)  
[PMC Article Link](https://pmc.ncbi.nlm.nih.gov/articles/PMC2865858/#T1)