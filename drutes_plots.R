.libPaths("Rlib")
library(withr)
library(ggplot2)
library(dplyr)
#library("ggpubr")
#theme_set(
#  theme_bw() +
#    theme(legend.position = "top")
#)

time_ser <- function(var, path, x_axis) {
  
  if (var %in% c("Temperature", "Liquid", "Ice", "Press_head", "Press_head_l", "Total_water", "Water_flow", "Cum_wat_flux", "Heat_flux", "Cum_heat_flux")){
  
    if(var %in% c("Temperature", "Heat_flux", "Cum_heat_flux")) {
    
      files <- list.files(path = paste0(path, "/out"), pattern = "obspt_heat-*", full.names = TRUE)
      obsp <- list()
      for (i in seq_along(files)) {
        dta <- read.table(files[i], skip = 10, col.names = c("time", "Temperature", "Heat_flux", "Cum_heat_flux"))
        dta$Temperature <- dta$Temperature - 273.15
        obsp[[i]] <- dta
      }
    } else {
      files <- list.files(path = paste0(path, "/out"), pattern = "obspt_RE_freeze_thaw-*", full.names = TRUE)
      obsp <- list()
      for (i in seq_along(files)) {
        dta <- read.table(files[i], skip = 10, col.names = c("time", "Press_head", "Total_water", "Liquid", "Press_head_l", "Ice", "theta_eq", "Water_flow", "Cum_wat_flux"))
        obsp[[i]] <- dta
      }
    }
  } else {
   stop("Error: Invalid input var. Please use: 'Liquid', 'Ice', 'Press_head', 'Press_head_l', 'Total_Water', 'Water_Flow', 'Cum_wat_flux', 'Temperature', 'Heat_flux', 'Cum_heat_flux'")
  }
  
  df <- bind_rows(lapply(seq_along(obsp), function(i) {
    obsp[[i]] %>% mutate(group = i)
  }))
  
  #depth_values <- c("1" = "0.15", "2" = "0.13", "3" = "0.11", 
    #                "4" = "0.09", "5" = "0.07", "6" = "0.05", 
   #                 "7" = "0.03", "8" = "0.01", "9" = "0")
  
  if (x_axis == TRUE) {
    plot <- ggplot(df, aes(x = time/3600, y = !!sym(var), color = factor(group))) +
      geom_line() +
      xlab("\ntime [h]") +
      ylab(paste0(var,"\n")) +
      scale_color_discrete(name = "Obs. point id \n(from top to bottom)") +
      #scale_color_manual(name = "Obs. point id \n(from top to bottom)", values = RColorBrewer::brewer.pal(nrow(df), "Set1")) +
      theme_minimal() +
      theme(legend.position = "top")
    
  } else {
    plot <- ggplot(df, aes(x = time/3600, y = !!sym(var), color = factor(group))) +
      geom_line() +
      xlab(NULL) +
      ylab(paste0(var,"\n")) +
      scale_color_discrete(name = "Obs. point id \n(from top to bottom)") +
      #scale_color_manual(name = "Obs. point id \n(from top to bottom)", values = RColorBrewer::brewer.pal(nrow(df), "Set1")) +
      theme_minimal() +
      theme(legend.position = "top")
    
    plot
    
  }

}

args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  stop("Error:variable not provided")
} else {
  arg1 <- args[1]
  arg2 <- ifelse(length(args) >= 2, args[2], "drutes")
  arg3 <- ifelse(length(args) >= 3, as.logical(args[3]), TRUE)

  out_file <- paste0("plot_", arg1,".pdf")

  pdf(out_file,  width = 9, height = 9)

  plot <- time_ser(arg1, arg2, arg3)
  print(plot)
  dev.off()
  print(paste("Plot saved to", out_file))
}


#a <- time_ser("Liquid", path = "drutes_runs/exp1", x_axis = FALSE)
#b <- time_ser("Ice", path = "drutes_runs/exp1", x_axis = FALSE)
#c <- time_ser("Temperature", path = "drutes_runs/exp1")

#figure <- ggarrange(a, b, c, ncol = 1 ,nrow = 3, common.legend = TRUE)

#figure
#pdf("figure.pdf", width = 9, height = 9)
#figure
#dev.off()
