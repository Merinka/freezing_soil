# freezing_soil
This repository contains results (out) and configuration files (drutes.config) from drutes freezing soil simulations (drutes_runs).  
Exp1 - Soil column experiment (dx = 0.0035 m)  
It also contains a link to the current version of Drutes and R script drutes_plots.R for plotting the results.  

###Required packages:  
make  
gfortran  
r-base (for plotting the results)  
<br/>
###Installation:  
`cd drutes`  
`make`  
`make clean`  
<br/>
###Running Drutes:  
`bin/drutes`  
<br/>
###Plotting:  
`Rscript drutes_plots.R [var] [path] [x.axis]`  
<br/>
***var***       variable you want to plot against time: 'Liquid', 'Ice', 'Press_head', 'Press_head_l', 'Total_Water', 'Water_Flow', 'Cum_wat_flux', 'Temperature', 'Heat_flux', 'Cum_heat_flux'  
***path***      path to a folder that contains out folder (default = drutes)  
***x.axis***    TRUE or FALSE, whether or not you want xlabel to display (defaul = TRUE)  
<br/>
example:  
`drutes_plots.R Temperature drutes_runs/exp1`  
