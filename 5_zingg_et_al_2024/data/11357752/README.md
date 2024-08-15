# Food production and biodiversity are not incompatible in temperate heterogeneous agricultural landscapes

# Authors: Silvia Zingg (a), Jan Grenz (a), Jean-Yves Humbert (b)

---

## Summary

In this study, yield figures provided by 299 farmers served to quantify the energy-equivalents of food production across different crops in 49 1-km2 landscapes. The results show that the relationship between bird diversity and food energy production depends on the proportion of farmland within the landscape, with a negative correlation observed in agriculture dominated landscapes (≥ 64–74% farmland). In contrast, neither typical farmland birds nor butterflies showed any significant relationship with total food energy production.

## Description of the data and file structure

We have submitted our R Script (Zingg_2023_R_Script_Imputation_Analyse_Figures.R), the raw data (Zingg_2023_RawData.csv), the post-processed imputed dataset (Zingg_2023_Completed_data_post_processed.csv), the dataset containing the crop areas from the agricultural survey and crop mapping  (Zingg_2023_Scaled_crop_area.csv), the dataset which was used for generalized linear models (GLM), combining he estimated food energy values and the biodiversity indicators per landscape (Zingg_2023_Data_for_modelling.csv). And the dataset that was used for the single species analysis (Zingg_2023_Data_for_modelling_Mean_Energy_Single_Species.csv). 

# Zingg\_2023\_R\_Script\_Imputation\_Analyse\_Figures.R

The R Script contains the code for the statistical analysis including the multiple imputation, the modelling and the main figures from the manuscript. All data sets needed are available as csv from DRYAD (see description below).

# Zingg\_2023\_RawData.csv

The Raw data contains information on all agricultural fields intersecting the 49 landscape squares.  Information was obtained from farmer interviews (= Farmer) and from cantonal agricultural surveys, or crop mapping (= Admin). 

*   *KoordID* = Landscape ID
*   *Kanton* = Name of the Swiss canton: AG = Aargau, BE = Bern, LU = Luzern, FR = Fribourg, VD = Vaud, SG = St. Gallen, TG = Thurgau
*   *Year* = Year of observation (2012 to 2016). Data from farmers is available for three consecutive years, information from the cantonal agricultural survey or crop mapping is available for one year.
*   *Crop* = Crop name (42 categories). Abbreviations: Ext. = Extensively managed, Int. = Intensively managed, BPA = Biodiversity promotion areas, Orn. = Ornamental
*   *Crop_Category* = Crops were grouped into 12 categories: 1) Cereals = Wheat, Barley, Oat, Rye, Sorghum, Spelt, Triticale and other cereals 2) Oilseed crops = Rapeseed, Soja and Sunflower 3) Leguminous_crops = Field bean, Protein pea and other Leguminous 4) Vegetables = Vegetables, Asparagus, other crops in greenhouses 5) Ext_grassland = Extensively managed meadows and pastures 6) Int_grassland = Intensively managed meadows and pastures and temporary grasslands (ley) 7) Non_edible = Wildflower strips or other non productive Biodiversity promotion areas (BPA) on arable land, Tobacco and other non-productive areas (e.g. christmas trees) 8) Fruits_Berries = Berries, Apple, Stone fruit, Pear and other orchards, Vine 9) Grain_maize = Grain maize, 10) Silage_maize = Silage maize, 11) Potato = Potatoes 12) Sugar_beet = Sugar and Fodder beet
*   *Label* = Form of production: Conv = Conventional production, Extenso = Extenso production (reduced pesticide application)
*   *Altitude* = Elevation in meters above sea level (m)
*   *Area_ha* = Field size in hectares (ha)
*   *Yield_dt* = Crop yield in decitons (dt), NA indicates the yield was not known.
*   *Use* = Number of cuts or grazing events per year (only given for grasslands). NA indicates the use was not known.
*   *Source* = Source of information: Farmer = information on agricultural fields and yields collected during farmer interviews (available for three years), Admin = information on agricultural fields from the cantonal agricultural survey or crop mapping (available for one year).

# Zingg\_2023\_Completed\_data\_post\_processed.csv

We used Multiple Imputation to impute missing yield values. Multiple imputation creates several (here n = 50) “complete” datasets by replacing missing values with plausible estimates. Each imputation represents a different set of imputed values. This file contains all 50 imputed and post-processed datasets.

Post processing:  Because Multiple Imputation can generate implausible values (e.g. 200 dt/ha for wheat), we restricted the yield values after the imputation, to the 1st and 3rd quartile of real yield values given by farmers. In addition non-edible crops, such as ornamental plants (e.g. Christmas trees) or non-productive Biodiversity promotion areas such as wildflower strips, or hedgerows were attributed a yield value of 0 and the yield figures for vegetables have been doubled (to account for two harvests per year).

*Reproducibility: Multiple imputation was used to create the dataset "Zingg_2023_Completed_data_post_processed.csv ". The imputation process involves randomness (e.g., random draws from distributions) and variability. As a result, even if the same analysis is repeated, the imputed values may differ slightly due to this inherent variability.*

*   *.imp* = Number of imputation (n = 50). The rawdata set was imputed 50 times. Every imputation contains 7727 entries (number of rows from the rawdata set)
*   *.id* = Row ID from the imputation (arable crops n = 4792 and grassland crops n=2034). Arable and grassland crops were were separately imputed and the datasets merged afterwards.

<!---->

*   *KoordID* = Landscape ID
*   *Kanton* = Name of the Swiss canton. AG = Aargau, BE = Bern, LU = Luzern, FR = Fribourg, VD = Vaud, SG = St. Gallen, TG = Thurgau
*   *Year* = Year of observation (2012 to 2016). Data from farmers is available for three consecutive years, information from the cantonal agricultural survey or crop mapping is available for one year.
*   *Crop* = Crop name (42 categories). Abbreviations: Ext. = Extensively managed, Int. = Intensively managed, BPA = Biodiversity promotion areas, Orn. = Ornamental
*   *Crop_Category* = Crops were grouped into 12 categories: 1) Cereals = Wheat, Barley, Oat, Rye, Sorghum, Spelt, Triticale and other cereals 2) Oilseed crops = Rapeseed, Soja and Sunflower 3) Leguminous_crops = Field bean, Protein pea and other Leguminous 4) Vegetables = Vegetables, Asparagus, other crops in greenhouses 5) Ext_grassland = Extensively managed meadows and pastures 6) Int_grassland = Intensively managed meadows and pastures and temporary grasslands (ley) 7) Non_edible = Wildflower strips on arable land (BPA), Tobacco and other non-productive areas (e.g. christmas trees) 8) Fruits_Berries = Berries, Apple, Stone fruit, Pear and other orchards, Vine 9) Grain_maize = Grain maize, 10) Silage_maize = Silage maize, 11) Potato = Potatoes 12) Sugar_beet = Sugar and Fodder beet
*   *Label* = Form of production: Conv = Conventional production, Extenso = Extenso production (reduced pesticide application)
*   *Altitude* = Elevation in meters above sea level (m)
*   *Area_ha* = Field size in hectares (ha)
*   *Yield_dt* = Crop yield in decitons (dt), NA indicates the yield was not known.
*   *Use* = Number of cuts or grazing events per year (only given for grasslands). NA indicates the use was not known.
*   *Source* = Source of information: Farmer = information on agricultural fields and yields collected during farmer interviews (available for three years), Admin = information on agricultural fields from the cantonal agricultural survey or crop mapping (available for one year).

# Zingg\_2023\_Scaled\_crop\_area.csv

To calculate the total produced food energy, the crop area per landscape (obtained from either the agricultural survey or crop mapping) must be adjusted according to the total amount of farmland within the landscape square. Notably, that the sum of all crop areas corresponds to the overall farmland area within that same landscape square. Therefore the scaled crop area (*Scaled_Area_ha*) was used to calculate the total produced food energy (see R Script).

*   *KoordID* = Landscape ID
*   *Crop_Category* = Crops were grouped into 12 categories: 1) Cereals = Wheat, Barley, Oat, Rye, Sorghum, Spelt, Triticale and other cereals 2) Oilseed crops = Rapeseed, Soja and Sunflower 3) Leguminous_crops = Field bean, Protein pea and other Leguminous 4) Vegetables = Vegetables, Asparagus, other crops in greenhouses 5) Ext_grassland = Extensively managed meadows and pastures 6) Int_grassland = Intensively managed meadows and pastures and temporary grasslands (ley) 7) Non_edible = Wildflower strips on arable land (BPA), Tobacco and other non-productive areas (e.g. christmas trees) 8) Fruits_Berries = Berries, Apple, Stone fruit, Pear and other orchards, Vine 9) Grain_maize = Grain maize, 10) Silage_maize = Silage maize, 11) Potato = Potatoes 12) Sugar_beet = Sugar and Fodder beet
*   *Area_ha* = Crop area per landscape (in hectares). The total area of all crops per landscape can exceed the total area of the farmland within the landscape square (because all intersecting agricultural fields were taken into account, also if partially outside the landscape square).
*   *Scale_fac* = Factor to scale the crop area to the total amount of farmland within the landscape square.
*   *Scaled_Area_ha* = Crop area per landscape (in hectares) scaled to the amount of farmland within the landscape square. The sum of the crop area equals the amount of farmland within the landscape square.

# Zingg\_2023\_Data\_for\_modelling.csv

For each of the 50 completed datasets, we calculated the mean crop yield per ha, averaging over all three sampling years and fields, within each landscape. Using this, and the scaled crop areas from the agricultural survey or crop mapping we calculated the total food energy production (in GJ of metabolizable energy ME per year), in each landscape for each imputed dataset. This dataset set contains the values for the the total produced food energy and the biodiversity indicators: Species Richness (SP), Abundance (Abun) and Pielous's evenness (Even) for birds and butterflies.

*KoordID* = Landscape ID

*.imp* = Number of imputation (n = 50).

*Scenario_1_Total_ME_GJ* = Total produced food energy per landscape (given as metabolizable energy for human consumption in Gigajoule) for scenario 1 (all food energy production directly consumed by humans)

*Scenario_2_Total_ME_GJ* = Total produced food energy per landscape (given as metabolizable energy for human consumption in Gigajoule) for scenario 2 (part of the production used as animal feed to produce meat)

*UAA* = Area of farmland in hectares (ha)

*Bird_Sp_All* = Total bird species richness

*Bird_Sp_K* = Farmland bird species richness

*Bird_Abun_All* = Total bird abundance

*Bird_Abun_K* = Farmland bird abundance

*Even_bird* = Bird evenness

*Butt_Sp_All* = Butterfly species richness

*Butt_Abun_All* = Butterfly abundance

*Even_butt* = Butterfly evenness

# Zingg\_2023\_Data\_for\_modelling\_Mean\_Energy\_Single\_Species.csv

The dataset contains information on the abundance (number of individuals) of different bird and butterfly species per landscape. "Zingg_2023_Data_for_modelling_Mean_Energy_Single_Species.csv" was used to generate the single species curves in the Supp. Mat.

*KoordID* = Landscape ID

*Mean_Scenario_1* = Total produced food energy per landscape (given as metabolizable energy for human consumption in Gigajoule) for scenario 1 (all food energy production directly consumed by humans) - Mean value from all imputed datasets

*Mean_Scenario_2* = Total produced food energy per landscape (given as metabolizable energy for human consumption in Gigajoule) for scenario 2 (part of the production used as animal feed to produce meat - Mean value from all imputed datasets

*UAA* = Area of farmland in hectares (ha)

Defined by the Latin names, the columns contain data on the abundance of 159 different bird and butterfly species.

## Sharing/Access information

Links to other publicly accessible locations of the data:

*   NA

Data was derived from the following sources:

*   See manuscript

## Code/Software

We used R Version 4.2.3. All packages and functions are given in the R Script.
