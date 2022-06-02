## code to prepare initial datasets goes here

# Install/load necessary packages
#install.packages("sf")
library(sf)
#install.packages("tmap")
library(tmap)
#install.packages("tidyr")
library(tidyr)
#install.packages("dplyr")
library(dplyr)
#install.packages("tidycensus")
library(tidycensus)


## LOAD IN ALL DATA
Detroit <- st_read("data-raw/DetroitBounds/City_of_Detroit_Boundary.shp")

Race80 <- read.csv("data-raw/1980Race/nhgis0003_ts_nominal_tract.csv")
HispLat80 <- read.csv("data-raw/1980HispLat/nhgis0004_ts_nominal_tract.csv")
TotPop80 <- read.csv("data-raw/1980TotalPop/nhgis0002_ds104_1980_tract.csv")
Pov80 <- read.csv("data-raw/1980Poverty/nhgis0008_ds107_1980_tract.csv")
#tracts1980 <- st_read("data-raw/USTracts1980/US_tract_1980.shp") (too large of a file to upload, included wrangled result .shp. Will leave steps one would have taken to get to the finish version.)
Dtracts80 <- st_read("data-raw/Det1980tract/Det1980tract.shp")

MI_SVI10 <- read.csv("data-raw/2010SVI/Michigan.csv")
#tracts2010 <- st_read("data-raw/USTracts2010/US_tract_2010.shp") (too large of a file to upload, included wrangled result .shp. Will leave steps one would have taken to get to the finish version.)
Dtracts10 <- st_read("data-raw/Det2010tract/Det2010tract.shp")


## Working with Spatial Data

st_crs(Detroit) #check CRS
#st_crs(tracts1980)
#st_crs(tracts2010)

Detroit3593 <- st_transform(Detroit, 3593) #change to a more appropriate CRS
#tracts80_3593 <- st_transform(tracts1980, 3593)
#tracts10_3593 <- st_transform(tracts2010, 3593)

#Dtracts80 <- st_join(tracts80_3593, Detroit3593, join = st_intersects, left=FALSE) #st_intersects allows for a "MOE"
#Dtracts10 <- st_join(tracts10_3593, Detroit3593, join = st_intersects, left = FALSE)

Detroit3593
Dtracts80
Dtracts10

#st_write(Detroit3593, "DetCityTracts.shp", append = FALSE)
#st_write(Dtracts80, "Det1980tract.shp", append=FALSE)
#st_write(Dtracts10, "Det2010tract.shp", append=FALSE)


## Wrangling 1980 data

#Demographic
MI_Race80 <- filter(Race80, STATE == "Michigan") #keep Michigan rows
MI_HispLat80 <- filter(HispLat80, STATE == "Michigan")
MI_Tot80 <- filter(TotPop80, STATE == "Michigan")


RACEna <- na.omit(MI_Race80) #omit NAs in filtered dataset
HISPLATna <- na.omit(MI_HispLat80)

Dem80 <- merge(RACEna, HISPLATna, by.x = "GJOIN1980", by.y = "GJOIN1980") #merge
DEM1980 <- merge(Dem80, MI_Tot80, by.x = "GJOIN1980", by.y = "GISJOIN") #merge again

MI_DEM80_cln1 <- DEM1980 %>%
  select(-(15:19)) #delete unecessary columns
MI_DEM80_cln2 <- MI_DEM80_cln1 %>%
  select(-(16:37))

MI_Demo <- MI_DEM80_cln2 %>%
  rename(white = B18AA1980, afrAm = B18AB1980, AmIndAKNat = B18AC1980, asian = B18AD1980, hisplat = A35AA1980, totPop1980 = C7L001, state = STATE.x, county = COUNTY.x) #rename columns

MI_DEM1980 <- MI_Demo %>%
  mutate(totpop1980Pr = (totPop1980/1203339)*100, hisplatPr80 = (hisplat/totPop1980)*100, whitePr80 = (white/totPop1980)*100, aframPr80 = (afrAm/totPop1980)*100, asianPr80 = (asian/totPop1980)*100, AmIndAKNatPr80 = (AmIndAKNat/totPop1980)*100) %>% select(GJOIN1980, state, county, totPop1980, totpop1980Pr, hisplatPr80, whitePr80, aframPr80, asianPr80, AmIndAKNatPr80) #standardize data


#Poverty
MI_Pov80 <- filter(Pov80, STATE == "Michigan") #keep Michigan rows


MI_Pov80 <- MI_Pov80 %>%
  rename(A_Poverty80 = DI8001, Poverty80 = DI8002) #rename columns


MI_POV1980 <- MI_Pov80 %>% select(-(2:13)) #delete unecessary columns


#Combine
MI_1980 <- merge(MI_DEM1980, MI_POV1980, by.x = "GJOIN1980", by.y = "GISJOIN")


MI_1980 %>%
  mutate(A_Poverty80Pr = (A_Poverty80/totPop1980)*100, Poverty80Pr = (Poverty80/totPop1980)*100) #create new variable

MI_1980

# Save as new .CSV
#write.csv(MI_1980, 'MI_1980.csv')



## Wrangling 2010 data

#Demographic - will need to input a census API key
DemVar2010 <- c(totPop2010 = "P001001", hisplat = "P004003", white = "P003002", afrAm = "P003003", asian = "P003005", AmIndAKNat = "P003004") #census API column "IDs"

MI_DEM2010 = get_decennial(geography = "tract", variables = DemVar2010, year = 2010, state = "MI", geometry = FALSE) %>%
  select(GEOID, NAME, variable, value) %>%
  spread(variable, value) %>%
  mutate(totpop2010Pr = (totPop2010/713777)*100, hisplatPr10 = (hisplat/totPop2010)*100, whitePr10 = (white/totPop2010)*100, aframPr10 = (afrAm/totPop2010)*100, asianPr10 = (asian/totPop2010)*100, AmIndAKNatPr10 = (AmIndAKNat/totPop2010)*100) %>%
  select(GEOID, totPop2010, totpop2010Pr, hisplatPr10, whitePr10, aframPr10, asianPr10, AmIndAKNatPr10) #access and standardize data


#Poverty(+)
pMI_SVI <- MI_SVI10 %>%
  mutate(Poverty = (E_P_POV *100), Unemployed = (E_P_UNEMP*100), PCI = (E_P_PCI*1), NoHSDip = (E_P_NOHSDIP*100), Above65 = (P_AGE65*100), Below17 = (P_AGE17*100), SngPrnt = (P_SNGPRNT*100), Minority = (P_MINORITY*100), LimEng = (E_P_LIMENG*100), Crowdness = (E_P_CROWD*100)) %>%
  select(FIPS, STATE_NAME, COUNTY,Poverty, Unemployed, PCI, NoHSDip, Above65, Below17, SngPrnt, Minority, LimEng, Crowdness) #standardize data


A_Poverty <- (100 - pMI_SVI$Poverty) #create new variable
pMI_SVI['A_Poverty'] <- A_Poverty
MI_SVI2010 <- pMI_SVI %>%
  relocate(A_Poverty, .before = Unemployed)


#Combine
MI_2010 <- merge(MI_DEM2010, MI_SVI2010, by.x = "GEOID", by.y = "FIPS")


colnames(MI_1980) #rearrange columns for the sake of uniformity
colnames(MI_2010)
MI_2010 <- MI_2010[, c(1, 9,10, 2, 3, 4, 5, 6, 7, 8, 12, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21)]

MI_2010

# Save as new .CSV
#write.csv(MI_2010, 'MI_2010.csv')


usethis::use_data(MI_1980, MI_2010, Dtracts10, Dtracts80, Detroit3593, overwrite = TRUE)

