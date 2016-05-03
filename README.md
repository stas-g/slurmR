#slurmR

`slurmR.r` reates submission scripts for Slurm on Darwin (for R scripts). It has one compulsory argument called `rscript` which should contain a name of the R script for which you wish to create an `sbatch` script (R script doesn't have to be in the directory from which `slurmR` is called, in which case you should provide a relative path).

Optionally one can pass any `#SBATCH` arguments you wish to use indstead of defaults. Defaults are stored in `create_subscript.r`, which is called by `slurmR` to fill in most of the `sbatch` submission script. `slurmR` completes it by addind `R` specific lines and saves it in the same directory as the original R script. 

`slurmR.r` assumes that helper script `create_subscript.r` is placed in a folder `my-bin` in your home directory (change this on line 7 of the script). 

Make executable from anywhere by including `export PATH="path-to-slurmR.r:$PATH"` in your `bashrc` file.

Examples of use:

creates `myScript-todaysdate.sh` in current directory:

`slurmeR.r "rscript='myRscript.R'"`

creates `myscript-todaysdate.sh` with default parameters `ntasks` and `time` overriden in directory Documents:

`slurmeR.r "rscript='Documents/myRscript.R'"` ntasks=10 "ttime='02:00:00'"
