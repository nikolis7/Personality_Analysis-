data = LOAD 'personality_analysis_clean.csv' USING PigStorage(',') AS (
    Index:int,
    ID:int,
    Year_Birth:int,
    Education:chararray,
    Marital_Status:chararray,
    Income:float,
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

A = FOREACH data GENERATE *;
M = FOREACH (GROUP A All) GENERATE AVG(A.MntWines) as avg_mnt;
C = FOREACH A GENERATE  *, (MntWines> ROUND(M.avg_mnt*1.5)? 'Yes' : 'No') as Class;
G1 = FILTER C BY Class=='Yes';
S = FOREACH G1 GENERATE ID,Age,Education,Marital_Status,Income,MntWines;
O = ORDER S BY MntWines DESC, Income DESC;
R = RANK O BY MntWines DESC,Income DESC,ID;

DUMP R;
STORE R INTO '3rd_output' USING PigStorage (',');
