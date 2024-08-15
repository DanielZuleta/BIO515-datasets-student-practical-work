# Channel Island *Melospiza melodia* (Song Sparrow) bill size, vegetation, climate, seed extraction time, and bite force

[https://doi.org/10.5061/dryad.wwpzgmsjc](https://doi.org/10.5061/dryad.wwpzgmsjc)

This dataset contains data from field measurements of Channel Island *Melospiza melodia* (Song Sparrow) bill morphology, vegetation within Song Sparrow habitats, climate associated with Song Sparrow sampling locations, individual seed extraction times, and bite force. Song Sparrows were sampled during the breeding season from 2014-2016 on three California Channel Islands (Santa Cruz Island, San Miguel Island, and Santa Rosa Island). 

Individual measurements of bill morphology and body size were used to determine whether bill metrics are significantly predicted by vegetation and climate. Bill depth and bill shape were used to determine whether bill morphology predicts bite force and/or seed extraction time in wild Song Sparrows. 

## Principal investigator contact information

All data files were originally created and compiled by** Maybellene P. Gamboa** (Assistant Professor, Department of Organismal Biology & Ecology, Colorado College; 14 E. Cache La Poudre St, Colorado Springs, CO 80903) in 2016 from physical data sheets with observations from 2014-2016. For scanned images of raw data sheets or for any questions or concerns, please contact M. P. Gamboa ([mgamboa@coloradocollege.edu](mailto:mgamboa@coloradocollege.edu)).

## Description of the data and file structure

Phenotypic and environmental datasets are provided with rows as individuals or sampling locations, respectively. Data files are labeled with the the relevant section in the R Markdown file and the type of data included in the file.

All files are saved as tabular or comma-delimited files. Please see R Markdown file for importing data into R to replicate analyses. Null values were not collected for individuals and/or for sampling locations. 

* **File: islandbill_analyses.Rmd** - R Markdown final with relevant analyses. Please see annotations within R Markdown file for details.
* **File: R1I_veg_conttable.txt** - Contigency tables of relative abundance of main vegetation types within 25 meters of mist-net location for captured Song Sparrows on the California Channel Islands during the breeding season from 2014-2016. Contigency tables were generated based on vegetation sampling (*see* **R1II_veg.csv**).
  * **Description of variables**
    * **category:** categorical [a = absent, t = trace (<10%), s = some (10-25%), p = prominent (25-50%), d = dominant (>50%)]; vegetation type and relative abundance of vegetation time within area
    * **cz:** numeric; number of occurrences of the category found in Song Sparrow sampling locations on Santa Cruz Island, California
    * **mi:** numeric; number of occurrences of the category found in Song Sparrow sampling locations on San Miguel Island, California
    * **ro** = numeric; number of occurrences of the category found in Song Sparrow sampling locations on Santa Rosa Island, California
* **File: R1II_veg.csv** - Habitat measurements and relative abundances of vegetation types within 25 meters of mist-net locations for captured Song Sparrows. Vegetation types were categorized based on walking through the designated area and visually scanning for focal vegetation types. Numeric ranks were used to run nonlinear principal component analyses on vegetation in mist-net sampling area to reduce vegetation to two primary vegetation axes. 
  * **Description of variables**
    * **date:** character (m/dd/yy); date of data collection
    * **observer:** character; individual collecting data
    * **ss1:** numeric; unique sample number associated with first captured Song Sparrow at mist-net location
    * **ss2:** numeric; unique sample number associated with second  captured Song Sparrow at mist-net location
    * **ss3:** numeric; unique sample number associated with third  captured Song Sparrow at mist-net location
    * **ss4:** numeric; unique sample number associated with fourth  captured Song Sparrow at mist-net location
    * **ss5:** numeric; unique sample number associated with fifth  captured Song Sparrow at mist-net location
    * **no_birds**:** **numeric; total number of Song Sparrows captured at mist-net location
    * **island:** categorical (CZ = Santa Cruz Island, MI = San Miguel Island, RO = Santa Rosa Island); island for mist-net location
    * **site_name:** character; unique identifier for mist-net sampling location
    * **location:** character; common name and/or general descriptive location for mist-net area 
    * **grass:** categorical [A = absent, T = trace (<10%), S = some (10-25%), P = prominent (25-50%), D = dominant (>50%)]; proportion of habitat sampling area covered by grasses (Family: Poaceae) based on visually scanning
    * **cbrush:** categorical [A = absent, T = trace (<10%), S = some (10-25%), P = prominent (25-50%), D = dominant (>50%)]; proportion of habitat sampling area covered by coyote brush (*Baccharis pilularis*) based on visually scanning
    * **fennel:** categorical [A = absent, T = trace (<10%), S = some (10-25%), P = prominent (25-50%), D = dominant (>50%)]; proportion of habitat sampling area covered by  fennel (*Foeniculum vulgare*) based on visually scanning
    * **lupine:** categorical [A = absent, T = trace (<10%), S = some (10-25%), P = prominent (25-50%), D = dominant (>50%)]; proportion of habitat sampling area covered by  lupine (*Lupinus *sp.) based on visually scanning
    * **sage:** categorical [A = absent, T = trace (<10%), S = some (10-25%), P = prominent (25-50%), D = dominant (>50%)]; proportion of habitat sampling area covered by  sage (*Salvia* sp. and *Artemisia* sp.) based on visually scanning
    * **forbs:** categorical [A = absent, T = trace (<10%), S = some (10-25%), P = prominent (25-50%), D = dominant (>50%)]; proportion of habitat sampling area covered by non-focal, non-graminoid, herbaceous flowering plants based on visually scanning
    * **other:** categorical [A = absent, T = trace (<10%), S = some (10-25%), P = prominent (25-50%), D = dominant (>50%)]; proportion of habitat sampling area covered by other vegetation or substrate specified in describe_OT column based on visually scanning
    * **grass_rank:** numeric (1-5; 1 = lowest relative abundance, 5 = highest relative abundance); numeric abundance rank of grasses (Family: Poaceae)  compared to other focal vegetation types
    * **cbrush_rank:** numeric (1-5; 1 = lowest relative abundance, 5 = highest relative abundance); numeric abundance rank of coyote brush (*Baccharis pilularis*) compared to other focal vegetation types
    * **fennel_rank:** numeric (1-5; 1 = lowest relative abundance, 5 = highest relative abundance); numeric abundance rank of fennel (*Foeniculum vulgare*) compared to other focal vegetation types
    * **lupine_rank:** numeric (1-5; 1 = lowest relative abundance, 5 = highest relative abundance); numeric abundance rank of lupine (*Lupinus* sp.) compared to other focal vegetation types
    * **sage_rank:** numeric (1-5; 1 = lowest relative abundance, 5 = highest relative abundance); numeric abundance rank of sage  (*Salvia* sp. and *Artemisia* sp.)  compared to other focal vegetation type
    * **forbs_rank:** numeric (1-5; 1 = lowest relative abundance, 5 = highest relative abundance); numeric abundance rank of non-focal, non-graminoid, herbaceous flowering plants  compared to other focal vegetation type
    * **other_rank:** numeric (1-5; 1 = lowest relative abundance, 5 = highest relative abundance); numeric abundance rank of  vegetation types or substrates specified in describe_OT column compared to other focal vegetation type
    * **describe_OT:** character; description of "other" vegetation types or substrates
* **File: R2I_billmorph**_**temp.csv** - Morphological measurements of every adult Song Sparrow captured and banded on the California Channel Islands during the breeding season in 2014-2016. Each bird is captured at a mist-net location, and vegetation dimensions based on nonlinear principal component analyses and maximum July temperature are included for each mist-net location. Please see included R Markdown for more information regarding the calculation of variables bill_sa D1, D2, bodsize, and billsc. File includes all captured adult birds and was used to generate maps in ArcGIS. File does not include vegetation dimensions for all mist-net locations.
  * **Description of variables**
    * **ss:** numeric; unique sample number associated with captured Song Sparrow
    * **band:** numeric; unique USGS band number associated with captured Song Sparrow
    * **site_name:** character; unique identifier for mist-net sampling location for Song Sparrow
    * **island:** categorical (CZ = Santa Cruz Island, MI = San Miguel Island, RO = Santa Rosa Island); island for mist-net sampling location
    * **year:** numeric (yyyy); year Song Sparrow was sampled
    * **zone:** numeric; North American Datum (NAD) of 1983 UTM zone for mist-net location
    * **utm_e**: numeric; North American Datum (NAD) of 1983 UTM easting for mist-net location
    * **utm_n**: numeric; North American Datum (NAD) of 1983 UTM northing for mist-net location
    * **sex:** character (F = female, M = male); biological sex of captured Song Sparrow based on presence of a cloacal protuberance (male) or brood patch (female)
    * **age:** character (ASY = after second year, SY = second year); adult age based on  feather molt pattern and overall feather wear
    * **mass:** numeric (g); total body mass in grams of captured Song Sparrow
    * **wing:** numeric (mm); total length in millimeters of captured Song Sparrow wing as measured from the carpal joint to distal end of longest primary feather on the right wing
    * **tarsus:** numeric (mm); total length in millimeters of  captured Song Sparrow tarsus as measured from inner bend of the tibiotarsal articulation to the base of the toes
    * **primext:** numeric (mm); total length in millimeters of  captured Song Sparrow primary feather extension measured from distal tip of the longest primary feather to the distal tip of the longest secondary feather on the right wing
    * **billd:** numeric (mm); total length in millimeters of  captured Song Sparrow bill depth measured at the distal tip of the nares
    * **billw:** numeric (mm); total length in millimeters of  captured Song Sparrow bill width measured at the distal tip of the nares
    * **billl:** numeric (mm); total length in millimeters of  captured Song Sparrow bill length measured from the distal tip of the nares to the distal tip of the maxilla
    * **bill_sa:** numeric (mm^2); total conical surface area of in square millimeters of  captured Song Sparrow bill based on bill depth, width, and length. Bill surface area was calculated following Greenberg and Danner (2012).
    * **maxt:** numeric (C); approximated maximum temperature in degrees Celsius in July at sampling location extracted from WorldClim2 (*see ***Sharing/Access Information ***below*). 
    * **D1:** numeric; primary axis of vegetation variation for mist-net sampling location using nonlinear principal component analyses. Refer to R Markdown for annotated analyses used to generate variable.
    * **D2:** numeric; secondary axis of vegetation variation for mist-net sampling location using nonlinear principal component analyses. Refer to R Markdown for annotated analyses used to generate variable.
    * **bodsize:** numeric; primary axis of body size variation for captured Song Sparrow based on principal component analysis of body mass and wing length.  Refer to R Markdown for annotated analyses used to generate variable.
    * **billsc:** numeric; Song Sparrow bill surface area corrected for body size. Refer to R Markdown for annotated analyses used to generate variable.
* **File: R2II_maxt.csv** - Maximum temperature approximated for each unique mist-net sampling location in July as extracted from WorldClim2 at 1km^2 resolution. File was used to determine whether maximum temperature significantly differed among islands at Song Sparrow mist-net sampling locations. 
  * **Description of variables**
    * **island:** categorical (CZ = Santa Cruz Island, MI = San Miguel Island, RO = Santa Rosa Island); island for mist-net sampling location
    * **site_name:** character; unique identifier for mist-net sampling location for Song Sparrow
    * **maxt:** numeric (C); approximated maximum temperature in degrees Celsius in July at sampling location extracted from WorldClim2 (*see ***Sharing/Access Information ***below*). 
* **File: R3I_lmmmodel_bill_temp_veg.csv** - File includes all  records of captured Song Sparrows from 2014-2016 with complete morphological measurements and vegetation measurements. File is a subset of data presented in **R2I_billmorph**_**temp.csv**. Please note that D1 is synonymous with veg1, and D2 is synonymous with veg2. File was used to test whether  maximum temperature and/or vegetation dimensions were a significant predictor for bill size corrected for body size using a linear mixed model. Please see included R Markdown for more information regarding use of file for analyses.
* **File: R5I_foraging_efficiency.csv** - Male Song Sparrows were captured in 2014, placed in cages, and fed nyjer seeds for seed extraction trials. Video recordings of seed extraction trials were used to determine the time in seconds for a Song Sparrow to fully unsheath a nyjer seed. File was used to determine whether there is a significant relationship between seed extraction time and bill dimensions. 
  * **Description of variables**
    * **ss:** numeric; unique sample number associated with captured Song Sparrow
    * **bill_sa:** numeric (mm^2); total conical surface area of in square millimeters of  captured Song Sparrow bill based on bill depth, width, and length. Bill surface area was calculated following Greenberg and Danner (2012).
    * **mass:** numeric (g); total body mass in grams of captured Song Sparrow
    * **wing:** numeric (mm); total length in millimeters of captured Song Sparrow wing as measured from the carpal joint to distal end of longest primary feather on the right wing
    * **billd:** numeric (mm); total length in millimeters of  captured Song Sparrow bill depth measured at the distal tip of the nares
    * **billw:** numeric (mm); total length in millimeters of  captured Song Sparrow bill width measured at the distal tip of the nares
    * **billl:** numeric (mm); total length in millimeters of  captured Song Sparrow bill length measured from the distal tip of the nares to the distal tip of the maxilla
    * **wing:** numeric (mm); total length in millimeters of captured Song Sparrow wing as measured from the carpal joint to distal end of longest primary feather on the right wing
    * **tomium:** numeric (s); total time in seconds taken for Song Sparrow to begin manipulating a nyjer seed to removing the exterior husk of the same nyjer seed 
    * **obs:** numeric; total number of seeds unhusked in seed extraction trial for the focal individual
    * **island:** categorical (CZ = Santa Cruz Island, MI = San Miguel Island, RO = Santa Rosa Island); island for mist-net sampling location
* **File: R52_foraging_pcs**_**individualmeasures.csv** - Data file includes individual Song Sparrow information presented in **R5I_foraging_efficiency.csv** and was used to generate descriptive statistics on birds included in foraging efficiency analyses. The first and second axes of variation from a principal component analysis of bill depth, width, and length are included as variables pc1 and pc2. Please see included R Markdown for more information regarding use of file for analyses.
* **File: R52_foraging_pcs**_**individualmeasures.csv** - File includes data presented in **R5I_foraging_efficiency.csv** and the first axis of variation from a principal component analysis of bill depth, width, and length, variable billpc. File was used to run a linear mixed model with individual as a random effect, pc1 of bill dimensions as a fixed effect, and seed extraction time as the response. Please see included R Markdown for more information regarding use of file for analyses.
* **File: R61_biteforce.csv** - Song Sparrows were captured in 2014 prior to the breeding season, measured, and included in bite force trials. Birds were repeated required to bite down on a tool to measure bite force. File was used to perform principal component analysis on body size metrics (wing and tarsus) to output one variable describing overall body size, to identify the maximum bite force, and to determine whether there was a relationship between bite order and bite force. Please see R Markdown File for analyses.
  * **Description of variables**
    * **band:** numeric; unique USGS band number associated with captured Song Sparrow.
    * **ss:** numeric; unique sample number associated with captured Song Sparrow.
    * **sex:** character (M = male, U = unknown); biological sex of captured Song Sparrow based on presence of a cloacal protuberance (male). If there was no evidence of a cloacal protuberance and no evidence of a brood patch, which would indicate a female bird, then the bird was marked as Unknown (U).
    * **age:** character (ASY = after second year, SY = second year); adult age based on  feather molt pattern and overall feather wear
    * **island:** categorical (CZ = Santa Cruz Island, MI = San Miguel Island, RO = Santa Rosa Island); island for mist-net sampling location
    * **mass:** numeric (g); total body mass in grams of captured Song Sparrow**bill_sa:** numeric (mm^2); total conical surface area of in square millimeters of  captured Song Sparrow bill based on bill depth, width, and length. Bill surface area was calculated following Greenberg and Danner (2012).
    * **mass:** numeric (g); total body mass in grams of captured Song Sparrow
    * **tarsus:** numeric (mm); total length in millimeters of  captured Song Sparrow tarsus as measured from inner bend of the tibiotarsal articulation to the base of the toes
    * **bill_d:** numeric (mm); total length in millimeters of  captured Song Sparrow bill depth measured at the distal tip of the nares
    * **bill_w:** numeric (mm); total length in millimeters of  captured Song Sparrow bill width measured at the distal tip of the nares
    * **bill_l:** numeric (mm); total length in millimeters of  captured Song Sparrow bill length measured from the distal tip of the nares to the distal tip of the maxilla
    * **bill_culmen:** numeric (mm); total length in millimeters of  captured Song Sparrow bill length measured from the proximal exposed end of the maxilla to the distal tip of the maxilla
    * **bill_sa:** numeric (mm^2); total conical surface area of in square millimeters of  captured Song Sparrow bill based on bill depth, width, and length. Bill surface area was calculated following Greenberg and Danner (2012).
    * **wing:** numeric (mm); total length in millimeters of captured Song Sparrow wing as measured from the carpal joint to distal end of longest primary feather on the right wing
    * **bite1:** numeric (N); total force in Newtons  Song Sparrow applied to bite meter in first bite
    * **bite1_time:** numeric; time (24-hour clock) when first bite was taken by Song Sparrow 
    * **bite2:** numeric (N); total force in Newtons  Song Sparrow applied to bite meter in second bite
    * **bite2_time:** numeric; time (24-hour clock) when second bite was taken by Song Sparrow 
    * **bite3:** numeric (N); total force in Newtons  Song Sparrow applied to bite meter in third bite
    * **bite3_time:** numeric; time (24-hour clock) when third bite was taken by Song Sparrow 
    * **bite_max:** numeric (N); maximum bite force of three bites taken by Song Sparrow in trial
    * **time_max:** numeric; time (24-hour clock) when maximum bite force was applied by Song Sparrow during trial
    * **bite_max_num:** numeric; number of bite that yielded the maximum bite force
* **File: R61_biteforce.csv** - File is a subset of data from **R61_biteforce.csv** and includes the first axis of body size variation following a principal component analysis of wing and tarsus. This simplified file was used to assess the relationship between bill depth, body size, and maximum bite force. Please see R Markdown File for analyses.
  * **Description of variables**
    * **island:** categorical (CZ = Santa Cruz Island, MI = San Miguel Island, RO = Santa Rosa Island); island for mist-net sampling location
    * **ss:** numeric; unique sample number associated with captured Song Sparrow.
    * **bill_d:** numeric (mm); total length in millimeters of  captured Song Sparrow bill depth measured at the distal tip of the nares
    * **bod:** numeric; first axis of body size variation (PC1) from principal component analysis of wing and tarsus
    * **bite_max:** numeric (N); maximum bite force of three bites taken by Song Sparrow in trial
* **File: climate_wrcc_raws.csv** - Climate data for Santa Cruz Island and Santa Rosa Island, California (2007-2016) and San Miguel Island, California (2007-2014) from remote automatic weather stations (RAWS) from the Western Regional Climate Center. File includes data for each month in the aforementioned years.
  * **Description of variables**
    * **island:** categorical (Santa Cruz = Santa Cruz Island, California, San Miguel = San Miguel Island, California, Santa Rosa = Santa Rosa Island, California)
    * **island_code:** categorical (cz = Santa Cruz Island, mi = San Miguel Island, ro = Santa Rosa Island); location for RAWS
    * **month:** categorical; three-letter month code
    * **var_wsmean_ms:** numeric (m/s); mean monthly wind speed in meters/second at island RAWS
    * **var_gustmax_ms:** numeric (m/s); maximum gust speed during month in meters/second at island RAWS
    * **var_tmean_c:** numeric (C); mean monthly temperature in Celsius at island RAWS
    * **var_tdailymax_c:** numeric (C); mean daily maximum temperature in Celsius at island RAWS
    * **var_tmax_c:** numeric (C);   maximum monthly temperature in Celsius at island RAWS
    * **var_tdailymin_c:** numeric (C); mean daily minimum temperature in Celsius at island RAWS
    * **var_tmin_c:** numeric (C);   minimum monthly temperature in Celsius at island RAWS
    * **var_rhmean_ms:** numeric (%); mean monthly relative humidity in percentage at island RAWS
    * **var_rhmax_ms:** numeric (%); maximum monthly relative humidity in percentage at island RAWS
    * **var_rhmin_ms:** numeric (%); minimum monthly relative humidity in percentage at island RAWS
    * **var_preciptot_inch:** numeric (inch); total precipitation in inches in month at island RAWS
* **File: climate_month_summary_2007-2016.csv** - Monthly summaries across years 2007-2016 for climate data for Santa Cruz Island, Santa Rosa Island, California, and San Miguel Island, California from remote automatic weather stations (RAWS) from the Western Regional Climate Center. 
  * **Description of variables**
    * **island_code:** categorical (cz = Santa Cruz Island, mi = San Miguel Island, ro = Santa Rosa Island); location for RAWS
    * **month:** categorical; three-letter month code
    * **month_code:** numeric; number associated with month in year
    *

    **var_wsmean_ms:** numeric (m/s); mean monthly wind speed in meters/second at island RAWS across years 2007-2016
    * **var_gustmax_ms:** numeric (m/s); maximum gust speed during month in meters/second at island RAWS across years 2007-2016
    * **var_tmean_c:** numeric (C); mean monthly temperature in Celsius at island RAWS across years 2007-2016
    * **var_tdailymax_c:** numeric (C); mean daily maximum temperature in Celsius at island RAWS across years 2007-2016
    * **var_tmax_c:** numeric (C);   maximum monthly temperature in Celsius at island RAWS across years 2007-2016
    * **var_tdailymin_c:** numeric (C); mean daily minimum temperature in Celsius at island RAWS across years 2007-2016
    * **var_tmin_c:** numeric (C);   minimum monthly temperature in Celsius at island RAWS across years 2007-2016
    * **var_rhmean_ms:** numeric (%); mean monthly relative humidity in percentage at island RAWS across years 2007-2016
    * **var_rhmax_ms:** numeric (%); maximum monthly relative humidity in percentage at island RAWS across years 2007-2016
    * **var_rhmin_ms:** numeric (%); minimum monthly relative humidity in percentage at island RAWS across years 2007-2016
    * **var_preciptot_inch:** numeric (inch); total precipitation in inches in month at island RAWS across years 2007-2016

## Sharing/Access information

All data was collected from 2014-2016 on the California Channel Islands and compiled by M. P. Gamboa (*see ***Principal investigator contact information**). Climate data was derived from the following sources:

* [WorldClim Version 2 ](https://www.worldclim.com/version2)
* [Western Regional Climate Center](https://wrcc.dri.edu/)

## Code/Software

Data files are labeled according to analyses. Annotated analyses in R, including packages used, may be found in the provided R Markdown.

## References

Greenberg, R., & Danner, R. M. (2012). The influence of the California marine layer on bill size in a generalist songbird. *Evolution*, *66*(12), 3825-3835.
