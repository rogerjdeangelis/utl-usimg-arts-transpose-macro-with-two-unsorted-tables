Usimg Art's transpose macro to with two unsorted tables                                                                                
                                                                                                                                       
github                                                                                                                                 
https://tinyurl.com/yy2er2sf                                                                                                           
https://github.com/rogerjdeangelis/utl-using-arts-transpose-macro-with-two-unsorted-tables                                             
                                                                                                                                       
SAS Forum                                                                                                                              
https://communities.sas.com/t5/SAS-Programming/transposing-data/m-p/571334                                                             
                                                                                                                                       
Transpose macro                                                                                                                         
AUTHORS: Arthur Tabachneck, Xia Ke Shan, Robert Virgile and Joe Whitehurst                                                             
                                                                                                                                       
macros                                                                                                                                 
https://tinyurl.com/y9nfugth                                                                                                           
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories                                             
                                                                                                                                       
*_                   _                                                                                                                 
(_)_ __  _ __  _   _| |_                                                                                                               
| | '_ \| '_ \| | | | __|                                                                                                              
| | | | | |_) | |_| | |_                                                                                                               
|_|_| |_| .__/ \__,_|\__|                                                                                                              
        |_|                                                                                                                            
;                                                                                                                                      
                                                                                                                                       
* I sorted the input data for documentation purposes only;                                                                             
                                                                                                                                       
data table1;                                                                                                                           
infile cards;                                                                                                                          
format account $3. date ddmmyy10. sum 8.;                                                                                              
informat account $3. date ddmmyy10. sum 8.;                                                                                            
input account--sum;                                                                                                                    
cards;                                                                                                                                 
A01 30/05/2019 100                                                                                                                     
A01 20/06/2019 110                                                                                                                     
A01 27/06/2019 120                                                                                                                     
A02 30/05/2019 10                                                                                                                      
A02 20/06/2019 20                                                                                                                      
A02 27/06/2019 30                                                                                                                      
;                                                                                                                                      
run;                                                                                                                                   
                                                                                                                                       
data table2;                                                                                                                           
infile cards;                                                                                                                          
format account $3. date ddmmyy10. segment $2. koef 8.3;                                                                                
informat account $3. date ddmmyy10. segment $2. koef 8.23;                                                                             
input account--koef;                                                                                                                   
cards;                                                                                                                                 
A01 21699 KB 0.74                                                                                                                      
A01 21720 KB 0.74                                                                                                                      
A01 21727 KB 0.74                                                                                                                      
A01 21699 RB 0.26                                                                                                                      
A01 21720 RB 0.26                                                                                                                      
A01 21727 RB 0.26                                                                                                                      
A02 21699 KB 0.66                                                                                                                      
A02 21720 KB 0.66                                                                                                                      
A02 21727 KB 0.66                                                                                                                      
A02 21699 RB 0.34                                                                                                                      
A02 21720 RB 0.34                                                                                                                      
A02 21727 RB 0.34                                                                                                                      
;                                                                                                                                      
run;                                                                                                                                   
                                                                                                                                       
*           _                                                                                                                          
 _ __ _   _| | ___  ___                                                                                                                
| '__| | | | |/ _ \/ __|                                                                                                               
| |  | |_| | |  __/\__ \                                                                                                               
|_|   \__,_|_|\___||___/                                                                                                               
                                                                                                                                       
;                                                                                                                                      
                                                                                                                                       
                                                                                                                                       
* transpose table 1 : NOTE THE SORT OPTION;                                                                                            
%utl_transpose(data=table1,out=tb1Xpo,by=account,var=sum,sort=account date);                                                           
                                                                                                                                       
Up to 40 obs from TB1XPO total obs=2                                                                                                   
                                                                                                                                       
  ACCOUNT    SUM1    SUM2    SUM3                                                                                                      
                                                                                                                                       
    A01       100     110     120                                                                                                      
    A02        10      20      30                                                                                                      
                                                                                                                                       
%utl_transpose(data=table2,out=tb2Xpo,by=account segment,var=koef segment,sort=account segment date);                                  
                                                                                                                                       
Up to 40 obs from TB2XPO total obs=4                                                                                                   
                                                                                                                                       
 ACCOUNT    SEGMENT1    KOEF1    SEGMENT2    KOEF2    SEGMENT3    KOEF3                                                                
                                                                                                                                       
   A01         KB        0.74       KB        0.74       KB        0.74                                                                
   A01         RB        0.26       RB        0.26       RB        0.26                                                                
   A02         KB        0.66       KB        0.66       KB        0.66                                                                
   A02         RB        0.34       RB        0.34       RB        0.34                                                                
                                                                                                                                       
* Left join the tqo transposed datasets;                                                                                               
                                                                                                                                       
*            _               _                                                                                                         
  ___  _   _| |_ _ __  _   _| |_                                                                                                       
 / _ \| | | | __| '_ \| | | | __|                                                                                                      
| (_) | |_| | |_| |_) | |_| | |_                                                                                                       
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                      
                |_|                                                                                                                    
;                                                                                                                                      
                                                                                                                                       
WORK.WANT total obs=4                                                                                                                  
                                                                                                                                       
  ACCOUNT    SUM1    SUM2    SUM3    KOEF1    KOEF2    KOEF3   SEGMENT1   SEGMENT2  SEGMENT3                                           
                                                                                                                                       
    A01       100     110     120     0.74     0.74     0.74      KB         KB        KB                                              
    A01       100     110     120     0.26     0.26     0.26      RB         RB        RB                                              
    A02        10      20      30     0.66     0.66     0.66      KB         KB        KB                                              
    A02        10      20      30     0.34     0.34     0.34      RB         RB        RB                                              
                                                                                                                                       
                                                                                                                                       
*          _       _   _                                                                                                               
 ___  ___ | |_   _| |_(_) ___  _ __                                                                                                    
/ __|/ _ \| | | | | __| |/ _ \| '_ \                                                                                                   
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                                                  
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                                                  
                                                                                                                                       
;                                                                                                                                      
                                                                                                                                       
%utl_transpose(data=table1,out=tb1Xpo,by=account,var=sum,sort=account date);                                                           
                                                                                                                                       
%utl_transpose(data=table2,out=tb2Xpo,by=account segment,var=koef segment,sort=account segment date);                                  
                                                                                                                                       
proc sql;                                                                                                                              
 create                                                                                                                                
     table want as                                                                                                                     
 select                                                                                                                                
     l.*                                                                                                                               
    ,r.*                                                                                                                               
 from                                                                                                                                  
    tb1Xpo as l left join tb2Xpo as r                                                                                                  
 on                                                                                                                                    
    l.account  =  r.account                                                                                                            
;quit;                                                                                                                                 
                                                                                                                                       
                                                                                                                                       
