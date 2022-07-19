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
O = ORDER F BY Income ASC;
R = RANK O BY Income ASC,ID ASC;
O1 = ORDER R BY $0;
G = GROUP O1 ALL;
C = FOREACH G GENERATE group AS ID, COUNT(O1) AS cnt; 

Q1 = FOREACH G GENERATE group AS ID, C.cnt*0.25 AS q1cnt; 
F1 = FILTER O1 BY $0==559;
F2 =  FOREACH F1 GENERATE Income;

Q3 = FOREACH G GENERATE group AS ID, C.cnt*0.75 AS q3cnt; 
F3 = FILTER O1 BY $0==1678;
F4 = FOREACH F3 GENERATE Income;

OUT1= FOREACH O1 GENERATE*, (Income > (F2.Income - 1.5* (F4.Income-F2.Income))? 'Yes': 'No') as outlier1;
OUT1F = FILTER OUT1 BY outlier1=='No'; 

OUT2= FOREACH O1 GENERATE*, (Income > (F4.Income + 1.5* (F4.Income-F2.Income))? 'Yes': 'No') as outlier2;
OUT2F = FILTER OUT2 BY outlier2=='No'; 

S = FOREACH OUT2F GENERATE ID,Year_Birth,Education,Marital_Status,Income,Kidhome,Teenhome,Dt_Customer,Recency,MntWines,MntFruits,MntMeatProducts,MntFishProducts,MntSweetProducts,MntGoldProds,NumDealsPurchases,
NumWebPurchases,NumCatalogPurchases,NumStorePurchases,NumWebVisitsMonth,AcceptedCmp3,AcceptedCmp4,AcceptedCmp5,AcceptedCmp1,AcceptedCmp2,Complain,Response,Age;;
DUMP S;

