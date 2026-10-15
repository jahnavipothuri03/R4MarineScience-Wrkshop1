
#WORKSHOP 2: 
#TITLE: ADVANCED DATA WRANGLING - EXTRACTING ECOLOGICAL SIGNALS FROM NOISY SYSTEMS
####################################################################################

library(tidyverse)
#---------------------------------------------------------------------------------------
#Tidying the datasets

#Using Tibble() to create a tidy dataset

#table1
#> # A tibble: 6 × 4
#>   country      year  cases population
#>   <chr>       <int>  <int>      <int>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3 Brazil       1999  37737  172006362
#> 4 Brazil       2000  80488  174504898
#> 5 China        1999 212258 1272915272
#> 6 China        2000 213766 1280428583
#table2
#> # A tibble: 12 × 4
#>   country      year type           count
#>   <chr>       <int> <chr>          <int>
#> 1 Afghanistan  1999 cases            745
#> 2 Afghanistan  1999 population  19987071
#> 3 Afghanistan  2000 cases           2666
#> 4 Afghanistan  2000 population  20595360
#> 5 Brazil       1999 cases          37737
#> 6 Brazil       1999 population 172006362
#> # ... with 6 more rows
#-----------------------------------------------------------------------------------
#Using pivot() to tidy the dataset
#Pivot_long() function used to make the dataset longer by gathering multiple columns into key-value pairs.
#billboard |> 
  #pivot_longer(
    #cols = starts_with("wk"), 
    #names_to = "week", 
    #values_to = "rank"
)
#> # A tibble: 24,092 × 5
#>    artist track                   date.entered week   rank
#>    <chr>  <chr>                   <date>       <chr> <dbl>
#>  1 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk1      87
#>  2 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk2      82
#>  3 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk3      72
#>  4 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk4      77
#>  5 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk5      87
#>  6 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk6      94
#>  #> # ℹ 24,082 more rows
#-------------------------------------------------------------------------------
#Three arguments in pivot_longer() function: cols, names_to, and values_to.
#cols: specifies the columns to pivot (in this case, all columns that start with "wk"
#names_to: specifies the name of the new column that will contain the names of the pivoted columns (in this case, "week")
#values_to: specifies the name of the new column that will contain the values of the pivot.
#---------------------------------------------------------------------------------------------------------
#billboard |> 
  #pivot_longer(
    #cols = starts_with("wk"), 
    #names_to = "week", 
    #values_to = "rank",
    #values_drop_na = TRUE
)
#> # A tibble: 5,307 × 5
#>   artist track                   date.entered week   rank
#>   <chr>  <chr>                   <date>       <chr> <dbl>
#> 1 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk1      87
#> 2 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk2      82
#> 3 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk3      72
#> 4 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk4      77
#> 5 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk5      87
#> 6 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk6      94
#> # ℹ 5,301 more rows
#----------------------------------------------------------------------------------------
#Pivoting longer- example
#create a dataset called dfwith 3 variables and their associated values.
#df <- tribble(
#~id,  ~bp1, ~bp2,
#"A",  100  120
#"B",  140  115
#"C",  120  125
)
#Need three measurements to be tidy
#id- already exists
#measurements(column names)
#values- (cell values)
#To make this happen, make pivot df longer.
#df |> 
  #pivot_longer(
    #cols = bp1:bp2,
    #names_to = "measurement",
    #values_to = "value"
)
#> # A tibble: 6 × 3
#>   id    measurement value
#>   <chr> <chr>       <dbl>
#> 1 A     bp1           100
#> 2 A     bp2           120
#> 3 B     bp1           140
#> 4 B     bp2           115
#> 5 C     bp1           120
#> 6 C     bp2           125
#--------------------------------------------------------------------------------
#Widening the datasets
#pivot_wider() function used to make the dataset wider by spreading key-value pairs across multiple columns.
#cms_patient_experience |> 
  #distinct(measure_cd, measure_title)
#> # A tibble: 6 × 2
#>   measure_cd   measure_title                                                 
#>   <chr>        <chr>                                                         
#> 1 CAHPS_GRP_1  CAHPS for MIPS SSM: Getting Timely Care, Appointments, and In...
#> 2 CAHPS_GRP_2  CAHPS for MIPS SSM: How Well Providers Communicate            
#> 3 CAHPS_GRP_3  CAHPS for MIPS SSM: Patient's Rating of Provider              
#> 4 CAHPS_GRP_5  CAHPS for MIPS SSM: Health Promotion and Education            
#> 5 CAHPS_GRP_8  CAHPS for MIPS SSM: Courteous and Helpful Office Staff        
#> 6 CAHPS_GRP_12 CAHPS for MIPS SSM: Stewardship of Patient Resources
#> #-----------------------------------------------------------------------------------
#Pivot(wider)
#cms_patient_experience |> 
  #pivot_wider(
    #id_cols = starts_with("org"),
    #names_from = measure_cd,
    #values_from = prf_rate
)
#> # A tibble: 95 × 8
#>   org_pac_id org_nm           CAHPS_GRP_1 CAHPS_GRP_2 CAHPS_GRP_3 CAHPS_GRP_5
#>   <chr>      <chr>                  <dbl>       <dbl>       <dbl>       <dbl>
#> 1 0446157747 USC CARE MEDICA...          63          87          86          57
#> 2 0446162697 ASSOCIATION OF ...          59          85          83          63
#> 3 0547164295 BEAVER MEDICAL ...          49          NA          75          44
#> 4 0749333730 CAPE PHYSICIANS...          67          84          85          65
#> 5 0840104360 ALLIANCE PHYSIC...          66          87          87          64
#> 6 0840109864 REX HOSPITAL INC          73          87          84          67
#> # ℹ 89 more rows
#> # ℹ 2 more variables: CAHPS_GRP_8 <dbl>, CAHPS_GRP_12 <dbl>
#--------------------------------------------------------------------------------------
#Pivoting exercises using Palmer penguins dataset
library(palmerpenguins)

# Create a long version of the penguins dataset

penguins_long <- penguins |>
  pivot_longer(
    cols = c(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g),
    names_to = "measurement_type",
    values_to = "value"
  )
# View the result
head(penguins_long)
#-------------------------------------------------------------------------------
penguins_long |>
  drop_na(value) |> ggplot(aes(x = value, fill = species)) +
  geom_histogram(bins = 30, alpha = 0.7, colour = "black") +
  facet_wrap(~ measurement_type, scales = "free_x") +
  theme_minimal() +
  labs(
    title = "Morphometric distributions across penguin species",
    x = "Measurement value",
    y = "Frequency"
  )
#-------------------------------------------------------------------------------
#Widening the dataset with pivot(wider)
mass_summary <- penguins |>
  drop_na(body_mass_g) |>
  group_by(species, island) |>
  summarise(mean_mass = mean(body_mass_g))

head(mass_summary)
#Output is tidy but not conceptually useful for publication. Use pivot_wider() to make it organised
mass_matrix <- mass_summary |>
  pivot_wider(
    names_from = island,
    values_from = mean_mass
  )
head(mass_matrix)
#-------------------------------------------------------------------------------------------------------
#Separating and uniting the data tables
#use separate() to split a single column into multiple columns
table3
#> # A tibble: 6 × 3
#>   country      year rate             
#> * <chr>       <int> <chr>            
#> 1 Afghanistan  1999 745/19987071     
#> 2 Afghanistan  2000 2666/20595360    
#> 3 Brazil       1999 37737/172006362  
#> 4 Brazil       2000 80488/174504898  
#> 5 China        1999 212258/1272915272
#> 6 China        2000 213766/1280428583
#Separate the dataset from case and population into two columns using separate() func
table3 %>% 
  separate(rate, into = c("cases", "population"))

#-------------------------------------------------------------------------
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")
#use convert(true) to convert the new columns into numeric values
table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)
#-------------------------------------------------------------------------------
#use pass vector to sepaarte the values and positions and split 
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)
#using unite() to combine multiple columns into a single column
table5 %>% 
  unite(new, century, year, sep = "")
#needed to ass sep="" to separate the values with a space
#---------------------------------------------------------------------------------
#Wrangling strings and dates
#Before we can merge datasets or plot timelines, we must standardize our text strings and date-times. The tidyverse includes two specialized packages for this: stringr for text and lubridate for dates.
#Standardising text with stringr
#stringr package begin with str_, making them easy to find using RStudio's autocomplete.

library(tidyverse)

# A remarkably messy data frame of field sites
messy_sites <- tibble(
  site_id = c(" Nelly Bay", "nelly_bay", "NELLY BAY", " Geoffrey_Bay ", "geoffrey bay")
)

# Using stringr within mutate to standardize the text
clean_sites <- messy_sites |>
  mutate(
    # 1. Convert everything to lowercase
    site_clean = str_to_lower(site_id),
    # 2. Replace any spaces with underscores
    site_clean = str_replace_all(site_clean, pattern = " ", replacement = "_"),
    # 3. Trim any leading or trailing whitespace (invisible spaces at the ends)
    site_clean = str_trim(site_clean)
  )

print(clean_sites)
#-----------------------------------------------------------------------------------
#Mastering time with lubridate
#lubridate package simplifies this by allowing you to parse dates by simply spelling out the order of the components: year, month, day, hour, minute, and second.

library(lubridate)

# Parsing different date formats
date_1 <- dmy("25/12/2026")
date_2 <- ymd("2026-12-25")

# R now recognizes these as identical Date objects
date_1 == date_2
#---------------------------------------------------------------------------
# A tibble of raw sensor data with a messy character timestamp
# A tibble of raw sensor data with a messy character timestamp
sensor_data <- tibble(
  raw_time = c("14-05-2026 08:30:00", "14-05-2026 08:45:00", "14-05-2026 
09:00:00"),
  temperature = c(24.5, 24.6, 24.4)
)

# Converting character strings to true POSIXct datetime objects
sensor_clean <- sensor_data |>
  mutate(
    true_time = dmy_hms(raw_time)
  )

print(sensor_clean)
#--------------------------------------------------------------------------------
#Relational data: Joining tables
# Table 1: Biological observation data
observations <- tibble(
  site_code = c("NB", "GB", "MI", "NB", "HB"),
  species = c("Trout", "Snapper", "Trout", "Cod", "Trout"),
  count = c(5, 2, 1, 3, 8)
)

# Table 2: Spatial metadata
site_metadata <- tibble(
  site_code = c("NB", "GB", "MI", "RP", "WP"),
  zone = c("Marine National Park", "Conservation Park", "Habitat Protection", "General Use", "Other Use"),
  lat = c(-19.16, -19.15, -19.14, -19.12, -19.11)
)
#-------------------------------------------------------------------------------------------------------------------
#The workhorse: left_ and right_join()
#left_join() and left_join() functions are the most common and safest joins to use (they work the same way but in opposite directions in terms of how your code is written).
#left_join()keeps all the rows from your left table (observations) and matches data from your right table (site_metadata) wherever the key matches. If a match is missing, it fills the gaps with NA.

# Joining metadata to our observations
joined_data <- observations |>
  left_join(site_metadata, by = join_by(site_code))

print(joined_data)
#-------------------------------------------------------------------------------------
#The strict filter: inner_join()
#inner_join() keeps only the rows that have matching keys in both tables. This is useful when you want to focus on the intersection of two datasets.
matched_data <- observations |>
  inner_join(site_metadata, by = join_by(site_code))
glimpse(matched_data)
#--------------------------------------------------------------------------------
#The detective: anti_join()
#anti_join() is the opposite of inner_join(). It returns only the rows from your left table that do not have a match in your right table. This is useful for identifying missing or unmatched data.
# Which observations are missing from our metadata dictionary?
missing_context <- observations |>
  anti_join(site_metadata, by = join_by(site_code))
#------------------------------------------------------------------------------------------
#Handling the missing data
#Converting legacy errors with na_if()
#You can fix this securely inside a mutate() using dplyr::na_if():
# Raw data from an old temperature logger
logger_data <- tibble(
  depth_m = c(10, 20, 30, 40),
  temp_c = c(24.5, 24.1, -999, 23.5)) # -999 is a known sensor error code

# Convert the -999 error codes to true NA values
fixed_logger <- logger_data |>
  mutate(temp_c = na_if(temp_c, -999))

print(fixed_logger)
#----------------------------------------------------------------------------
#Replacing missing values with coalesce()
# coalesce() allows you to replace NA values with a specified default value use dplyr::coalesce() inside a mutate() to hunt down every NA in a specific column and replace it with a 0 (or any other fixed value).
# Simulate some count data
shark_counts <- tibble(
  site = c("Reef_A", "Reef_B", "Reef_C"),
  shark_count = c(3, NA, 5)) # The NA here actually means 0 sharks were seen

# Replace NA with 0 
shark_fixed <- shark_counts |>
  mutate(shark_count = coalesce(shark_count, 0))

print(shark_fixed)
#------------------------------------------------------------------------------------------
#coalesce() is incredibly powerful. If you have two columns, like a primary_sensor and a backup_sensor, coalesce(primary_sensor, backup_sensor) will automatically use the primary reading, but seamlessly fill in the gaps with the backup reading if the primary had failed!)
#The special case of NaN (Not a Number)
#One distinct type of missing value worth mentioning is NaN (Not a Number). While NA means "we do not know what this value is", NaN means "this value is mathematically impossible.
cpue_data <- tibble(
  site = c("Bay_1", "Bay_2"),
  catch = c(10, 0),
  effort_hours = c(2, 0))

# Calculating CPUE (catch / effort)
cpue_calc <- cpue_data |>
  mutate(
    cpue = catch / effort_hours)

print(cpue_calc)
#---------------------------------------------------------------------------------
#Implicit missing values and the zero-data framework: complete()
raw_catch <- tibble(
  site = c("Reef_1", "Reef_1", "Reef_2"),
  species = c("Pmaculatus", "Pleopardus", "Pmaculatus"),
  count = c(5, 2, 8))
#-------------------------------------------------------------------------------
#use tidyr::complete() to build a zero-data framework. 
#This function finds all unique combinations of the variables you supply, explicitly creates rows for the missing combinations, and allows you to fill the resulting NAs with 0.
# Force inclusion of hidden zero-catch data
full_catch_matrix <- raw_catch |>
  complete(site, species, fill = list(count = 0))

print(full_catch_matrix)
#----------------------------------------------------------------------------
#The nuclear option: drop_na()
sensor_log <- tibble(
  day = 1:4,
  salinity = c(35.2, 35.1, NA, 35.3)
)

# Remove any row where salinity is missing
clean_log <- sensor_log |>
  drop_na(salinity)
#------------------------------------------------------------------------------
########################################################################################################
#EXCERCISE1: CLEANING THE MESSY DAATSET
# Make sure packages are loaded
library(tidyverse)
library(palmerpenguins)

# The messy metadata provided by your colleague
island_metadata <- tibble(
  island_name = c(" biscoe", "Dream ", "Torgersen"),
  station_install = c("15/01/2003", "22-03-2004", "05/11/2001"),
  latitude = c(-64.81, -64.73, -64.76)
)

print(island_metadata)
#------------------------------------------------------------------------------
#Need to clean the messy dataset

clean_metadata <- island_metadata |>
  mutate(
    # 1. Trim whitespace from island names
    island_name = str_to_title(str_trim(island_name)),
    # 2. Convert station_install to a proper date format
    station_install = dmy(str_replace_all(station_install, "-", "/"))
  )

print(clean_metadata)
#---------------------------------------------------------------------------
#Check to see if it matches the penguins dataset
unique(penguins$island)
unique(clean_metadata$island_name)
#------------------------------------------------------------------------------
################################################################################
#EXCERCISE2: THE RELATIONAL JOIN
# Make sure packages are loaded
penguins_spatial <- penguins %>%
  left_join(clean_metadata, by = join_by(island == island_name))
head(penguins_spatial)
#------------------------------------------------------------------------------
#############################################################################
#EXERCISE3: THE WIDE SUMMARY MATRIX
penguins_summary <- penguins_spatial %>%
  drop_na(body_mass_g) |>
  group_by(species, island) |>
  summarise(max_body_mass = max(body_mass_g), .groups = "drop") |>
  pivot_wider(
    names_from = island,
    values_from = max_body_mass
  )
penguins_summary
#-----------------------------------------------------------------------------------------------------
#####################################################################################
#KEYSTONE EXERCISE: ESTUARY FISH SURVERY, DATA RESCUE MISSION
#PHASE1: Ingestion & Decontamination
#PHASE2: The Relational Architecture
#PHASE3: The Zero-catch Framework
#PHASE4: Statistical Extraction
#PHASE5: Visual Communication

#load the required packages
library(tidyverse)
library(readxl)
library(lubridate)
#-----------------------------------------------------------------------------
# ============================================================
# PHASE 1: DATA INGESTION AND CLEANING
# ============================================================
#Import and combine all the data sets
# Import catch data
catch_file <- file.choose()
catch_sheets <- excel_sheets(catch_file)

# Import metadata
metadata_file <- file.choose()
metadata <- read_csv(metadata_file)

# Import sonde data
sonde_file <- file.choose()
sonde <- read_csv(sonde_file)

# Import species dictionary
dictionary_file <- file.choose()
species_dictionary <- read_csv(dictionary_file)
#------------------------------------------------------------------------------
catch_sheets
dim(metadata)
dim(sonde)
dim(species_dictionary)
#--------------------------------------------------------------------------
#Combine all the catch data sheets into a single data frame
catch_data <- map_dfr(
  catch_sheets,
  ~ read_excel(catch_file, sheet = .x)
)
dim(catch_data)
names(catch_data)
glimpse(catch_data)
head(catch_data)
#messy original data is represented below
#need to standardize it
#---------------------------------------------------------------------------------
#Need to clean the species names and make them consistent with the species dictionary
distinct(catch_data  , site)
distinct(catch_data  , species)
#----------------------------------------------------------------------------------

catch_clean <- catch_data |>
  mutate(
    site = site |>
      str_to_lower() |>
      str_trim() |>
      str_replace_all("\\s+", "_"),
    
    species = species |>
      str_to_lower() |>
      str_trim() |>
      str_replace_all("\\s+", "_")
  )
#-------------------------------------------------------------------------------
distinct(catch_clean, site)
distinct(catch_clean, species)
#the names are standardised
#need to check with the dates now
#-----------------------------------------------------------------------------
class(catch_clean$date)
range(catch_clean$date)
# need to clean the metadata
#------------------------------------------------------------------------------
metadata
#Four site names with lat, long and zones are visibile in the console
#need to run the clean matching site column
metadata_clean <- metadata |>
  mutate(
    site = site_name |>
      str_to_lower() |>
      str_trim() |>
      str_replace_all("\\s+", "_")
  )
distinct(metadata_clean, site)
#----------------------------------------------------------------------------------
#check whether the catch sites and meta data sites match
anti_join(
  catch_clean |> distinct(site),
  metadata_clean |> distinct(site),
  by = "site"
)
#no catch sites are missing from the metadata, so we can proceed to join the two datasets
#--------------------------------------------------------------------------------------------------
#now we need to clean the species dictionary
species_dictionary
#cleaning the common-name column
species_dictionary_clean <- species_dictionary |>
  mutate(
    common_name = common_name |>
      str_to_lower() |>
      str_trim() |>
      str_replace_all("\\s+", "_")
  )
species_dictionary_clean

anti_join(
  catch_clean |> distinct(species),
  species_dictionary_clean |> distinct(common_name),
  by = c("species" = "common_name")
)
#--------------------------------------------------------------------------------------------
#now we need to check the relational workflow, clean each dataset first, then join them

glimpse(sonde)
head(sonde)
#Now to standardise the sonde site names
sonde_clean <- sonde |>
  mutate(
    site = site |>
      str_to_lower() |>
      str_trim() |>
      str_replace_all("\\s+", "_")
  )
distinct(sonde_clean, site)
#now to parse the timestamp
#-------------------------------------------------------------------------------------
head(sonde_clean$timestamp)
sonde_clean <- sonde_clean |>
  mutate(
    datetime = dmy_hm(timestamp)
  )
class(sonde_clean$datetime)
range(sonde_clean$datetime)
head(sonde_clean$timestamp, 10)
head(
  sonde_clean |>
    select(timestamp, datetime),
  10
)
sum(is.na(sonde_clean$datetime))
#---------------------------------------------------------------------------------
#find the -999 errors sensor readings
sum(sonde_clean$turbidity == -999)
sonde_clean <- sonde_clean |>
  mutate(
    turbidity = na_if(turbidity, -999)
  )
sum(sonde_clean$turbidity == -999, na.rm = TRUE)
sum(is.na(sonde_clean$turbidity))
#------------------------------------------------------------------------------
#need to create a date from timestamp
sonde_clean <- sonde_clean |>
  mutate(
    date = floor_date(datetime, unit = "day")
  )
head(
  sonde_clean |>
    select(site, datetime, date)
)
#------------------------------------------------------------------------------
# ============================================================
# PHASE 2: RELATIONAL ARCHITECTURE
# ============================================================

#daily water quality summary data
sonde_daily <- sonde_clean |>
  group_by(site, date) |>
  summarise(
    mean_temperature = mean(
      temperature,
      na.rm = TRUE
    ),
    mean_salinity = mean(
      salinity,
      na.rm = TRUE
    ),
    .groups = "drop"
  )
dim(sonde_daily)
head(sonde_daily)
summary(sonde_daily$mean_salinity)
#-----------------------------------------------------------------------------
#translate common names into scientific names
catch_taxonomy <- catch_clean |>
  left_join(
    species_dictionary_clean,
    by = c("species" = "common_name")
  )
catch_taxonomy |>
  select(species, scientific_name) |>
  distinct()
catch_taxonomy |>
  filter(is.na(scientific_name))
#----------------------------------------------------------------------------------
#join the fish data with the metadata
catch_spatial <- catch_taxonomy |>
  left_join(
    metadata_clean |>
      select(site, lat, lon, zone),
    by = "site"
  )
glimpse(catch_spatial)
#---------------------------------------------------------------------------
sum(is.na(catch_spatial$zone))
sum(is.na(catch_spatial$lat))
#------------------------------------------------------------------------------
#The grand join
master_observed <- catch_spatial |>
  left_join(
    sonde_daily,
    by = c("site", "date")
  )
dim(master_observed)
sum(is.na(master_observed$mean_salinity))
sum(is.na(master_observed$mean_temperature))
#-----------------------------------------------------------------------------
# ============================================================
# PHASE 3: ZERO-CATCH FRAMEWORK
# ============================================================

#zero-catch framework
master_complete <- master_observed |>
  complete(
    site,
    date,
    scientific_name,
    fill = list(count = 0)
  )
dim(master_complete)
sum(master_complete$count == 0, na.rm = TRUE)
sum(is.na(master_complete$count))
#-------------------------------------------------------------------------------
colSums(is.na(master_complete))
#--------------------------------------------------------------------------
#build a sit-date environmental table
site_day_info <- master_observed |>
  distinct(
    site,
    date,
    lat,
    lon,
    zone,
    mean_temperature,
    mean_salinity
  )
dim(site_day_info)
#-----------------------------------------------------------------------------
#Add environ info to zero framework
master_final <- master_complete |>
  select(
    site,
    date,
    scientific_name,
    count
  ) |>
  left_join(
    site_day_info,
    by = c("site", "date")
  )
dim(master_final)
glimpse(master_final)
#--------------------------------------------------------------------------
#Final master quality check
nrow(master_final)
sum(master_final$count == 0)
sum(is.na(master_final$count))
sum(is.na(master_final$scientific_name))
sum(is.na(master_final$zone))
sum(is.na(master_final$mean_salinity))
#-----------------------------------------------------------------------------
# ============================================================
# PHASE 4: STATISTICAL SUMMARY
# ============================================================
#make the statistical summary table
summary_table <- master_final |>
  group_by(
    zone,
    scientific_name
  ) |>
  summarise(
    mean_fish_count = mean(count, na.rm = TRUE),
    sd_fish_count = sd(count, na.rm = TRUE),
    mean_salinity = mean(mean_salinity, na.rm = TRUE),
    sd_salinity = sd(mean_salinity, na.rm = TRUE),
    .groups = "drop"
  )
summary_table
nrow(summary_table)
#----------------------------------------------------------------------------
#making the table easier to read
summary_table <- summary_table |>
  mutate(
    mean_fish_count = round(mean_fish_count, 2),
    sd_fish_count = round(sd_fish_count, 2),
    mean_salinity = round(mean_salinity, 2),
    sd_salinity = round(sd_salinity, 2)
  )
summary_table
#-----------------------------------------------------------------------------
# ============================================================
# PHASE 5: VISUALISATION
# ============================================================
#making the ggplot 
ggplot(
  master_final,
  aes(
    x = mean_salinity,
    y = count
  )
) +
  geom_point() +
  facet_wrap(~ scientific_name) +
  theme_minimal() +
  labs(
    x = "Mean salinity",
    y = "Fish abundance (count)",
    title = "Fish abundance along the estuarine salinity gradient"
  )
#--------------------------------------------------------------------------------
#adding asthetics and making the graph publication-ready
ggplot(
  master_final,
  aes(
    x = mean_salinity,
    y = count
  )
) +
  geom_jitter(
    width = 0.15,
    height = 0.08,
    alpha = 0.6
  ) +
  facet_wrap(
    ~ scientific_name
  ) +
  theme_minimal(base_size = 12) +
  labs(
    x = "Mean salinity (PSU)",
    y = "Fish abundance (count)",
    title = "Fish abundance along the estuarine salinity gradient"
  ) +
  theme(
    plot.title = element_text(
      face = "bold",
      size = 14
    ),
    axis.title = element_text(
      face = "bold"
    ),
    strip.text = element_text(
      face = "italic"
    )
  )
#-------------------------------------------------------------------------------
master_final <- master_final |>
  mutate(
    species_label = case_when(
      scientific_name == "Lates calcarifer" ~
        "italic('Lates~calcarifer')",
      
      scientific_name == "Lutjanus argentimaculatus" ~
        "italic('Lutjanus~argentimaculatus')",
      
      scientific_name == "Acanthopagrus spp." ~
        "italic('Acanthopagrus')~'spp.'",
      
      scientific_name == "Platycephalus spp." ~
        "italic('Platycephalus')~'spp.'"
    )
  )
#-------------------------------------------------------------------------------
#make the final plot
final_plot <- ggplot(
  master_final,
  aes(
    x = mean_salinity,
    y = count
  )
) +
  geom_jitter(
    width = 0.15,
    height = 0.08,
    alpha = 0.6
  ) +
  facet_wrap(
    ~ species_label,
    labeller = label_parsed
  ) +
  theme_minimal(base_size = 12) +
  labs(
    x = "Mean salinity (PSU)",
    y = "Fish abundance (count)",
    title = "Fish abundance along the estuarine salinity gradient"
  ) +
  theme(
    plot.title = element_text(
      face = "bold",
      size = 14
    ),
    axis.title = element_text(
      face = "bold"
    ),
    strip.text = element_text(
      size = 11
    )
  )

final_plot
#------------------------------------------------------------------------------
ggsave(
  "estuary_fish_salinity_plot.png",
  plot = final_plot,
  width = 10,
  height = 7,
  dpi = 300
)
#----------------------------------------------------------------------------
write_csv(
  master_final,
  "estuary_master_dataset.csv"
)

write_csv(
  summary_table,
  "estuary_summary_table.csv"
)
###############################################################################

