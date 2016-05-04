#v 0.55 --> 01.05.2016

#default #SBATCH settings
job_id <- "myRjob"
account <- "CWALLACE-SL3"
nodes <- 1
ntasks <- 1
ttime <- "01:00:00"
mail <- "FAIL"
mem <- 63900
p <- "sandybridge"

body_ <- "
. /etc/profile.d/modules.sh # Leave this line (enables the module command)
module purge                # Removes all modules still loaded
module load default-impi    # REQUIRED - loads the basic environment
module load R/3.2.3 # latest R
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
JOBID=$SLURM_JOB_ID
echo -e \"JobID: $JOBID
echo \"Time: `date`
echo \"Running on master node: `hostname`
echo \"Current directory: `pwd`
if [ \"$SLURM_JOB_NODELIST\" ]; then
        #! Create a machine file:
        export NODEFILE=`generate_pbs_nodefile`
        cat $NODEFILE | uniq > machine.file.$JOBID
        echo -e \"\\nNodes allocated:\\n================\"
        echo `cat machine.file.$JOBID | sed -e \\'s/\\..*$//g\\'`
fi"

#given a path, write all the language independent part of the submission script
write_subscript <- function(path){
	file.create(path)

	write("#!/bin/bash", file = path, append = TRUE)
	write("", file = path, append = TRUE)

	write(paste("#SBATCH -J", job_id), file = path, append = TRUE)
	write(paste("#SBATCH -A", account), file = path, append = TRUE)
	write(paste("#SBATCH --nodes", nodes), file = path, append = TRUE)
	write(paste("#SBATCH --ntasks", ntasks), file = path, append = TRUE)
	write(paste("#SBATCH --time", ttime), file = path, append = TRUE)
	write(paste("#SBATCH --mail-type", mail), file = path, append = TRUE)
	write(paste("#SBATCH --mem", mem), file = path, append = TRUE)
	write(paste("#SBATCH -p", p), file = path, append = TRUE)

	write(body_, file = path, append = TRUE)
	write("", file = path, append = TRUE)
}
