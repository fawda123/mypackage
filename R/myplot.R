#' My awesome plot function
#'
#' My awesome plot function that creates summary plots
#'
#' @param tbhdat input dataset
#' @param Scientificname chr string of species to plot
#'
#' @return A summary plot and table
#' @export
#'
#' @import dplyr
#' @import ggplot2
#' @import patchwork
#' @import gridExtra
#' @import tidyr
#'
#' @examples
#' tbhdat <- read.csv('example_len_dat.csv')
#' myplot(tbhdat, 'Lagodon rhomboides')
myplot <- function(tbhdat, Scientificname) {

  # preprocess length data
  Plot <- tbhdat %>%
    filter(Scientificname == !!Scientificname) %>%
    ggplot() +
    geom_histogram(aes(x=sl), color = "black", fill = NA, binwidth = 10) +
    labs(x = "Standard length (mm)", y = "Frequency") +
    facet_wrap(~ Gear, ncol = 1) +
    theme_classic() +
    theme(panel.border = element_rect(color = "black", fill = NA)) +
    theme(strip.background = element_rect(fill = "gray90"))

  #get length summary data
  summary <- tbhdat %>%
    filter(Scientificname == !!Scientificname) %>%
    group_by(Gear) %>%
    summarise(min_sl = min(sl),
              max_sl = max(sl),
              mean_sl = round(mean(sl), digits = 2),
              sd_sl = round(sd(sl), digits = 2),
              Num_lengths = n()) %>%
    ungroup()

  # combine plot and summary table
  Plot / gridExtra::tableGrob(summary, rows = NULL) +
    plot_layout(heights = c(2,0.8)) +
    plot_annotation(title = Scientificname, theme= theme(plot.title = element_text(face = "italic")))

}
