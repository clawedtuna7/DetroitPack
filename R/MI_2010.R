#' Data containing demographic poverty (and other) related data for the state of Michigan in the year 2010
#'
#'
#' @format A data frame with 2781 rows and 21 variables:
#' \describe{
#'   \item{GEOID}{chr GIS Join Match Code}
#'   \item{STATE_NAME}{chr State Name}
#'   \item{COUNTY}{chr County Name}
#'   \item{totPop2010}{int denotes total Population per tract}
#'   \item{totpop2010Pr}{num denotes the proportion of the total population in each tract based on the total population count of the City of Detroit in 2010}
#'   \item{hisplatPr10}{num denotes the proportion of those identifying as Hispanic or Latino in each tract}
#'   \item{whitePr10}{num denotes the proportion of those identifying as White in each tract}
#'   \item{aframPr10}{num denotes the proportion of those identifying as Black or African American in each tract}
#'   \item{asianPr10}{num denotes the proportion of those identifying as Asian, and Pacific Islander, and Other Race in each tract}
#'   \item{AmIndAKNatPr10}{num denotes the proportion of those identifying as American Indian and Alaska Native in each tract}
#'   \item{A_Poverty10}{int denotes the proportion of those living above poverty in each tract}
#'   \item{Poverty10}{int denotes the proportion of those living below poverty in each tract}
#'   \item{Unemployed}{num Proportion of civilian (age 16+) unemployed estimate}
#'   \item{PCI}{num Per capita income estimate, 2006-2010 ACS}
#'   \item{NoHSDip}{num Proportion of persons with no high school diploma (age 25+) estimate}
#'   \item{Above65}{num Proportion of persons aged 65 and older}
#'   \item{Below17}{num Proportion of persons aged 17 and younger}
#'   \item{SngPrnt}{num Proportion of single parent households with children under 18}
#'   \item{Minority}{num Proportion minority (all persons except white, non-Hispanic)}
#'   \item{LimEng}{num Proportion of persons (age 5+) who speak English "less than well" estimate}
#'   \item{Crowdness}{num Proportion of households with more people than rooms estimate}
#' }
#' @source \url{http://doi.org/10.18128/D050.V16.0}
#' @source \url{https://www.atsdr.cdc.gov/placeandhealth/svi/data_documentation_download.html}
"MI_2010"
