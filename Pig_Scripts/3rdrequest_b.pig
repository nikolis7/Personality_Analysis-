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

fields_data = FOREACH data GENERATE Index, ID, Age, Education, Marital_Status, Income, MntWines;
order_data = ORDER fields_data BY MntWines DESC;
dump order_data;