# VpThemAll

This package has assistant functions to wrap and perform variation partition with dbRDA method. In other words, this package aims to assist to test the effect of several variables in a multivariate set, having "partitioned out" the effect of other variables in consideration. It requires vegan and stringr.

--------------
## Motivation

VpThemAll is a wrapper of vegan package functions. It's core is the varpart function of [vegan package](https://github.com/vegandevs/vegan). **All its routines, however, can be performed with vegan package functions.** The package was created to make coding easier and analysis reproducible, particularly when having many variables. It is used to calculate variation of a community explained by a given variable (e.g. environmental) having controlled by the effect of other variables in the test. ANOVA is used to test the significance of the variable to explain the community.

Tested with vegan version 2.4-5. Some higher versions may produce NA instead of a valid adj.r.square. This should be fixed with later versions (for instance, vegan 2.5-7). See discussion on the subject on [vegan github page](https://github.com/vegandevs/vegan/issues/295).

## Installation

1. Clone/download the repository at the desired directory.

   ```bash
   #at the desired directory location
   git clone https://git.embl.de/grp-bork/vpthemall.git
   #Go to the clone directory
   cd vpthemall
   ```

   

2. Install R and required packages (optional)

   This code was tested with vegan packages 2.4-5 and stringr 1.4+. You will also need devtools to install the package. To make sure you have the right packages you could use the code in an conda environment. This will also keep the installation contained and not mess up with your current R environment. If you have the packages and versions required, you can skip this step.

   ```bash
   # Create conda environment with the the yml file at conda.env
   conda env create -f conda.env/environment.yml
   
   # Load environment
   conda activate r.vpthemall
   
   # Open R and install vegan from the archive
   R
   install.packages("permute") #Need for installing vegan
   install.packages("https://cran.r-project.org/src/contrib/Archive/vegan/vegan_2.4-5.tar.gz", repos = NULL) # Install vegan
   install.packages("devtools")# Install devtools
   quit()
   ```

   

3. Install vpthemall using devtools

   ```R
   # in R
   library(devtools)
   install("./")
   quit()
   ```



## Usage

Usage check the **tutorial** at ./tutorial/tutorial.html.
