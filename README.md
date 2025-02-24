# freezing_soil
This repository contains results (out) and configuration files (drutes.config) from Drutes freezing soil simulations (drutes_runs).  
Experiment 1 (Exp1): Soil column experiment (dx = 0.0035 m).  
It also includes a link to the current version of Drutes and an R script (drutes_plots.R) for plotting the results.  
Drutes is run from the command line. For more information, visit https://drutes.org/  
<br/>
**Required packages:**  
make  
gfortran  
r-base (for plotting the results)  
<br/>
**Installation:**  
`cd drutes`  
`make`  
`make clean`  
<br/>
**Running Drutes:**  
`bin/drutes`  
<br/>
**Plotting:**  
`Rscript drutes_plots.R [var] [path] [x.axis]`  
<br/>
***var***       The variable to plot against time. Options:
                'Liquid', 'Ice', 'Press_head', 'Press_head_l', 'Total_Water', 'Water_Flow', 'Cum_wat_flux', 'Temperature', 'Heat_flux', 'Cum_heat_flux'.  
***path***      The path to the folder containing the out folder (default = drutes)  
***x.axis***    TRUE or FALSE – whether to display the x-axis label (default = TRUE)  
<br/>
example:  
`Rscript drutes_plots.R Temperature drutes_runs/exp1`  
