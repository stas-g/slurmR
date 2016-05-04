#slurmR

`slurmR` creates submission scripts for Slurm on Darwin (for R scripts). It has one compulsory argument called `rscript` which should contain a name of the R script for which you wish to create a submission `sbatch` script.

Optionally one can pass any `#SBATCH` arguments you wish to use indstead of defaults. All such arguments has to be appropriately named: you can find (and change) default settings and arguments' names in `create_subscript.r`. Numeric arguments can be simply passed as e.g. `mem=20000`. Use of double quotation marks is required to pass string arguments, e.g. `"job_id='myjob'"`. Additionally you can switch between different `SL` accounts by simply passing e.g. `account=2` (instead of `"account='CWALLACE-SL2'"`).

*set-up:*

`slurmR` assumes that helper script `create_subscript.r` is placed in folder `my-bin` in your home directory (change this on line 7 of the script if you want to put it somewhere else). 
Make `slurmR` executable from anywhere by including `export PATH="path-to-slurmR.r:$PATH"` in your `bashrc` file. You will then be able to run it in any directory to create a submission file in any other directory (if you would like to do that you will need to provide a relative path, see below).

*Examples of use:*

creates `myRscript-todaysdate.sh` in current directory:

`slurmeR.r "rscript='myRscript.R'"`

creates `myRscript-todaysdate.sh` with default settings `ntasks` and `ttime` (time) overriden in directory Documents:

`slurmeR.r "rscript='Documents/myRscript.R'" ntasks=10 "ttime='02:00:00'"`
