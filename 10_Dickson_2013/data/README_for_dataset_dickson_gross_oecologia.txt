ReadMe file for:
Dickson, T. L. and K. L. Gross. 2013. Plant community responses to long-term fertilization: changes in functional group abundance drive changes in species richness. Oecologia 173:1513-1520.  DOI: 10.1007/s00442-013-2722-8

This file describes the data in “dataset_dickson_gross_oecologia.xlsx” for the above publication. Each spreadsheet is described below along with an explanation of variates. Note that cells containing a “.” indicate data are missing or not available. For further inquiries please contact Timothy Dickson (tdickson@unomaha.edu).	

Spreadsheets in “dataset_dickson_gross_oecologia.xlsx”:
1.  raw_data 
2.  raw_data_amended
3.  t7_soil_n
4.  subplot_soil_n
5.  burn
6.  field_operations_log

1. Spreadsheet: raw_data

Description: Raw data of plant species composition and biomass in unfertilized and fertilized subplots of the unclipped Early Successional treatment (T7) of the Main Cropping System Experiment at KBS LTER, 1989–2012. See https://lter.kbs.msu.edu/datatables/154 for extended data.	

Variate		Description
event_name	specific sampling activity “ANPP = above ground net primary productivity”
year		year of sampling
sample_date	date of sampling (month/day/year)
plotID		code given to each subplot based on replicate block - MCSE treatment - fertilizer treatment
block		replicate block number “1, 2, 3, 4, 5, 6”
fert		fertilizer treatment “0 = no fertilizer added; 1= fertilizer added”, see materials and methods or field operations log for specifics
stdcode		standardized code used for plant species. See https://lter.kbs.msu.edu/datatables/4 for taxonomic description.
biomass		dry mass of plant sample (g DM)
area_sampled	area sampled (m2)
comment		a note specific to the sample

2. Spreadsheet: raw_data_amended

Description: Raw data (1989–2011) as in spreadsheet 1, but amended to 1) include species taxonomic, morphological, and growth classification; 2) include areal biomass and species richness; and 3) remove data on SDEAD (standing dead), SURFL (surface litter), and UNSRT (unidentifiable and unsorted pieces of biomass). These removed data were not included in the analyses because they all contained all or at least a portion of biomass that was not produced in the year of harvest. We just wanted to examine richness and growth of plants that were produced in the year of harvest. Data presented in Figures 1-3 and S3-S6.

Variate		Description
year		year of sampling
stdcode		standardized code used for plant species. See https://lter.kbs.msu.edu/datatables/4 for taxonomic description.
cot		number of cotyledons “M=monocot; D= dicot”
dur		life history “A=annual; B=bienneial; P=perennial”
lf		life form “F=forb; S=shrub; G=graminoid”
dlf		detailed life form “L=legume; NL=non-legume forb; ES=evergreen shrub; DS= deciduous shrub; C3 =C3 grass; C4= C4 grass”. If species was a legume and shrub, then coded as LS.
ht		relative height  “B=bottom third; M=middle third; U=upper third”
clo		clonality “R=runner; C=clumper; O=non-clonal”
origin		origin “Native, non-native”
plotID		code given to each subplot based on replicate block - MCSE treatment - fertilizer treatment
block		replicate block number	
tilled		tilled (0=subplot not tilled)
fert		fertilizer treatment “0 = no fertilizer added; 1= fertilizer added”, see materials and methods or field operations log for specifics
biomass		dry mass of plant sample (g DM)
areal_biomass	dry mass of plant per squared meter (g DM m-2)
richness	number of plant species per area_sampled
area_sampled	area sampled (m2)
comment		a note specific to the sample

3. Spreadsheet:  t7_soil_n

Description: Yearly average soil nitrogen concentrations (ammonia plus nitrate) in the main plots (i.e. unfertilized and unclipped vegetation surrounding the subplots where the experiment was completed) of the Early Successional (T7) treatment of the Main Cropping System Experiment, 1989–2011. See https://lter.kbs.msu.edu/datatables/55 for extended data and for complete ammonia and nitrate data set. Data presented in Figure S1A.

Variate		Description
block		replicate block number	
year		year of sampling
average_soil_n	yearly average ammonia plus nitrate concentration, as N, in soils (?g N g-1 soil).  

4.  Spreadsheet:  subplot_soil_n

Description: Yearly average soil nitrogen concentrations (ammonia plus nitrate) of the unfertilized and fertilized subplots in Early Successional (T7) plots of the Main Cropping System Experiment, 1996–2011. See https://lter.kbs.msu.edu/datatables/348 for complete ammonia and nitrate data set plus soil moisture. Data presented in Figure S1B.

Variate		Description
plotID		code given to each subplot based on replicate block - MCSE treatment - fertilizer treatment
year		year of sampling
block		replicate block number
fert		fertilizer treatment “0 = no fertilizer added; 1= fertilizer added”, see materials and methods or field operations log for specifics
average_soil_n	yearly average ammonia plus nitrate concentration, as N, in soils (?g N g-1 soil)

5.  Spreadsheet: burn

Description: Richness of species in subplots of the Early Successional treatment (T7) of the Main Cropping System Experiment, 1997–2011, including information on the years that spring prescribed burning occurred. Data presented in Figure S2.

Variate		Description
plotID		code given to each subplot based on replicate block - MCSE treatment - fertilizer treatment
block		replicate block number
fert		fertilizer treatment “0 = no fertilizer added; 1= fertilizer added”, see materials and methods or field operations log for specifics
year		year of sampling
richness	number of plant species per area sampled
burn		annual spring burn “0 = no burn in year; 1 = burn conducted in year ”

6.  Spreadsheet: gain_loss

Description: Gain and loss of species in subplots of the Early Successional treatment (T7) of the Main Cropping System Experiment, 1994–2011. Data presented in Figure S7.

Variate		Description
plotID		code given to each subplot based on replicate block - MCSE treatment - fertilizer treatment
block		replicate block number
fert		fertilizer treatment “0 = no fertilizer added; 1= fertilizer added”, see materials and methods or field operations log for specifics
gain		number of species gained in preceding two years (see manuscript supplementary material for more information) 
loss		number of species lost in preceding two years (see manuscript supplementary material for more information)
years		gains and losses of species were calculated for the two years preceding the listed years

7. field_operations_log

Description: Log of agronomic activity in subplots of the Early Successional treatment (T7) of the Main Cropping Systems Experiment.

Variate		Description
date		date of agronomic activity	
type		type of agronomic activity
event		specific detail of agronomic activity
location	subplots were activity was performed



