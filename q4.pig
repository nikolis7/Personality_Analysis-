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

G = FOREACH A GENERATE  *, ((mnt_total> ROUND(M.avg_mnt*0.5)) AND (Income > 69500) AND (date_customer>2020)? 'Gold' : 'Other') as Class; 

S = FOREACH A GENERATE  *, ((mnt_total> ROUND(M.avg_mnt*0.5)) AND (Income > 69500) AND (date_customer<2021)? 'Silver' : 'Other') as Class; 


G1 = FILTER G BY Class=='Gold';
G2 = FOREACH G1 GENERATE Class, ID; 
G3 = ORDER G2 BY ID DESC;

S1 = FILTER S BY Class=='Silver';
S2 = FOREACH S1 GENERATE Class, ID; 
S3 = ORDER S2 BY ID DESC;

GS = UNION G3, S3;

--DUMP GS; 


X = FOREACH (GROUP GS BY Class) GENERATE group as Class, TOTUPLE(GS.ID) as id;

DUMP X;


































*/



X = FOREACH (GROUP GS BY Class) GENERATE group as Class, SUM(GS.ID);

 X = FOREACH (GROUP GS BY Class) {
	 	Y = FILTER GS BY All;
	 GENERATE
		group AS Class,
		FLATTEN(ID) AS id;
 	};




*/




/*

A = FOREACH data GENERATE ID, Income, GetYear(Dt_Customer) as date_customer , (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) as mnt_total;

MEANS = FOREACH (GROUP A All) GENERATE AVG(A. mnt_total) as mean_mnt, AVG(A. Income) as mean_income;

MEAN_MNT = foreach MEANS GENERATE MEANS.$0*0.5;





-- MEAN_INCOME = foreach MEANS GENERATE MEANS.$1;
-- B = FILTER A BY (Income > 69500) AND (date_customer > 2020);








C = FOREACH A GENERATE  ID, ((mnt_total> ROUND(MEAN_MNT)) AND (Income > 69500) AND (date_customer>2020)? 'Gold' :((mnt_total> ROUND(303)) AND (Income > 69500) AND (date_customer<2020)) ? 'Silver' : 'Other')); 





G1 = FOREACH A GENERATE  *, ((mnt_total> ROUND(303)) AND (Income > 69500) AND (date_customer>2020)? 'Gold' : 'Other') as Class; 

G2 = ORDER G1 by ID DES;

G = FILTER G2 BY Class=='Gold';


S1 = FOREACH A GENERATE  *, ((mnt_total> ROUND(303)) AND (Income > 69500) AND (date_customer<2021)? 'Silver' : 'Other') as Class; 

S2 = ORDER S1 by ID DESC;

S = FILTER S2 BY Class=='Silver'; 



GS = UNION G, S;

data_GS = FOREACH GS GENERATE Class, ID;


groupedGS = GROUP data_GS BY Class;


X = FOREACH (GROUP groupedGS All) GENERATE group, GS.ID;




orderedGS = ORDER GS BY ID ASC;

finalGS = FOREACH orderedGS GENERATE Class, ID;

groupGS = GROUP finalGS BY Class; 



(b=='1' ? 'abc' : (b=='2' ? 'xyz' : a))



C = FOREACH A GENERATE  *, (Income > 69500?
							(date_customer>2020?
								(mnt_total>0.5*MEAN_MNT?'Gold':
									(date_customer<2020?
									(Income>69500?
											(mnt_total>0.5*MEAN_MNT?'Silver':' ') 
											)	   
										)
									)			   
								)				
							);					
					


C = FOREACH A GENERATE  *, (Income > 69500?(date_customer>2020?(mnt_total>0.5*MEAN_MNT?'Gold':(date_customer<2020?(Income>69500?(mnt_total>0.5*MEAN_MNT?'Silver':' '))))))); 
																	
								
C = FOREACH A GENERATE  *, (Income > 69500?(date_customer>2020?(mnt_total>0.5*MEAN_MNT?'Gold':'Silver'); 








(Price > 75 ? 'High':'Low') as Indicator


C = FOREACH B GENERATE *, (
  CASE
    WHEN Income > 69500 THEN 1
  END
);





C = foreach B generate *, (int)(RANDOM(1)) as rnd;

C = foreach B generate *, (int)(100) as Class;


C = foreach B generate *, (chararray)(UPPER("gold")) as rnd;


C = FOREACH B GENERATE *, gold as Class:chararray;



C = FOREACH B GENERATE *, CONCAT('gold = ');



--Register 'myudf.py' using streaming_python as myfuncs;

--register 'myudf.py' using org.apache.pig.scripting.streaming.python.PythonScriptEngine as myfuncs;

--a= LOAD 'names.csv' USING PigStorage(',') AS (Name:chararray);


--b = foreach a generate Name, myfuncs.gold(Name);


--count = FOREACH D GENERATE COUNT(C) as cnt;


-- groupedu = GROUP data BY Education;
-- count = FOREACH groupedu GENERATE group as education_status, COUNT(data) as cnt;
-- ordered_data = ORDER count BY education_status;
-- dump ordered_data;


*/










