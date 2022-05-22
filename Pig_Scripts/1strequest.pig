data = LOAD 'personality_analysis.csv' USING PigStorage(';') AS (	
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
	Response:int
	);

DESCRIBE data;

A = FOREACH data GENERATE *;
T = FOREACH A GENERATE *,  (2022 - Year_Birth) as Age;
F = FILTER T BY Age <120;
I = FILTER F BY Income >0;
M = FOREACH (GROUP I All) GENERATE AVG(I.Income) as avg_mnt;
C = FOREACH I GENERATE  *, (Income> ROUND(M.avg_mnt*1.75)? 'Yes' : 'No') as incomeoutliers;
G1 = FILTER C BY incomeoutliers=='No';
dump G1;




	