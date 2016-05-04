#slurmR

`slurmR.r` creates submission scripts for Slurm on Darwin (for R scripts). It has one compulsory argument called `rscript` which should contain a name of the R script for which you wish to create a submission `sbatch` script (R script doesn't have to be in the directory from which `slurmR` is called, in which case you should provide a relative path).

Optionally one can pass any `#SBATCH` arguments you wish to use indstead of defaults. All such arguments has to be appropriately named. Numeric arguments can be simply passed as e.g. `mem=20000`. Use of double quotation marks is required to pass string arguments, e.g. `"job_id='myjob'"`. Default settings and arguments' names aar stored in `create_subscript.r`, which is called by `slurmR` to fill in most of the `sbatch` submission script using either defaults or options values provided by the user. `slurmR` completes the script by addind `R` specific lines and saves it in the same directory in which the original R script is supposed to be. 

*set-up*
`slurmR.r` assumes that helper script `create_subscript.r` is placed in folder `my-bin` in your home directory (change this on line 7 of the script if you want to put it somewhere else). 
Make `slurmR` executable from anywhere by including `export PATH="path-to-slurmR.r:$PATH"` in your `bashrc` file. You will then be able to run it in any directory to create a submission file in any other directory.

*Examples of use:*

creates `myRscript-todaysdate.sh` in current directory:

`slurmeR.r "rscript='myRscript.R'"`

creates `myRscript-todaysdate.sh` with default settings `ntasks` and `ttime` (time) overriden in directory Documents:

`slurmeR.r "rscript='Documents/myRscript.R'" ntasks=10 "ttime='02:00:00'"`
