#!/usr/bin/Rscript --vanilla

# v0.55 --> 01.05.2016

source(paste0(path.expand("~"), "/my-bin/create_subscript.r"))

# reading in arguments passed to the script: must contain 'rscript' argument specifying the path to the R script to run and optinoal #SBATCH options
args <- commandArgs(trailingOnly = TRUE)
# parsing and creating objects (eg. parsing "ntasks=10" to create an integer ntasks with value 10)
# if any arguments named as the #SBATCH options are passed defaults values for those are overwritten
for(i in 1 : length(args)) eval(parse(text = args[i]))
# account argument accepts a numeric input (3) or a full account name
if(account == 4) account <- "CWALLACE-SL4"


# if R script in not in the directory from which slurmer is called, parse the path
if(grepl("/", rscript)){
	(r <- regmatches(rscript, regexec("(.+/)(([^/]+)\\.(r|R))", rscript))[[1]])
	#path to script
	path <- r[2]
	#script name minus the .R(r) extension
	sname <- r[4]
	#actual script name
	rscript <- r[3]
} else {
	#remove the .R(r) extension
	sname <- gsub("(.(R|r))$", "", rscript)
	path <- ""
}

# logfile name
logname <- paste0(sname, "-", format(Sys.Date(), format = "%m%d%y"), ".log")
# name of the sbatch script (should be date + name of the R script (not the path!) + .sh)
sname <- paste0(sname, "-", format(Sys.Date(), format = "%m%d%y"), ".sh")
# path to where it should be saved (same directory as the original R script)
new_path <- paste0(path, sname)

write_subscript(new_path)

write(sprintf("srun -n%s R CMD BATCH %s %s &", ntasks, rscript, logname), file = new_path, append = TRUE)

write("wait", file = new_path, append = TRUE)
