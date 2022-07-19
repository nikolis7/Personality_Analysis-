data = LOAD 'personality_analysis_clean.csv' USING PigStorage(',') AS (
	Index:int,
	ID:int,
	Year_Birth:int,
	Education:chararray,
	Marital_Status:chararray,
	Income:int,
	Kidhome:int,
	Teenhome:int,
	Dt_Customer:datetime,
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


A = FOREACH data GENERATE ID, Income, GetYear(Dt_Customer) as date_customer , (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) as mnt_total;

M = FOREACH (GROUP A All) GENERATE AVG(A.mnt_total) as avg_mnt;

G = FOREACH A GENERATE  *, ((mnt_total> ROUND(M.avg_mnt*1.5)) AND (Income > 69500) AND (date_customer>2020)? 'Gold' : 'Other') as Class; 

S = FOREACH A GENERATE  *, ((mnt_total> ROUND(M.avg_mnt*1.5)) AND (Income > 69500) AND (date_customer<2021)? 'Silver' : 'Other') as Class; 


G1 = FILTER G BY Class=='Gold';
G2 = FOREACH G1 GENERATE Class, ID; 
G3 = ORDER G2 BY ID DESC;

S1 = FILTER S BY Class=='Silver';
S2 = FOREACH S1 GENERATE Class, ID; 
S3 = ORDER S2 BY ID DESC;

GS = UNION G3, S3;

--DUMP GS; 


X = FOREACH (GROUP GS BY Class) GENERATE group as Class, TOTUPLE(GS.ID) as id;

--DUMP X;

STORE X INTO '4th_output' USING PigStorage (',');






















