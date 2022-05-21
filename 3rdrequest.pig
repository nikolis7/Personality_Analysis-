data = LOAD 'personality_analysis_clean.csv' USING PigStorage(',') AS (	
	Index:int,
	ID:int,
	Year_Birth:int,
	Education:chararray,
	Marital_Status:chararray,
	Income:float,
	Kidhome:int,
	Teenhome:int,
	Dt_Customer:chararray,
	Recency:int,
	MntWines:int,
	MntFruits:int,
	MntMeatProducts:int,
	MntFishProducts:int,
	MntSweetProducts:int,
	MntGoldProds:int,
	NumDealsPurchases:int,
	NumWebPurchases:int,
    NumCatalogPurchases:int,
	NumStorePurchases:int,
	NumWebVisitsMonth:int,
	AcceptedCmp3:int,
	AcceptedCmp4:int,
	AcceptedCmp5:int,
	AcceptedCmp1:int,
    AcceptedCmp2:int,
	Complain:int,
	Response:int,
	Age:int
	);

totalaverage = FOREACH (GROUP data ALL) GENERATE AVG(data.MntWines) AS totalwinesaverage;
newcolumn =  FOREACH data GENERATE  *, (data.MntWines> ROUND(totalaverage.totalwinesaverage*1.5)? 'Yes' : 'No') as Class; 
filterdata = FILTER newcolumn BY Class=='Yes';
dump filterdata;

