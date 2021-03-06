*Examine the distribution of wife’s hours of work graphically and numerically

. sum whrs, de

                    Wife's hours of work
-------------------------------------------------------------
      Percentiles      Smallest
 1%            0              0
 5%            0              0
10%            0              0       Obs                 250
25%            0              0       Sum of Wgt.         250

50%        406.5                      Mean             799.84
                        Largest       Std. Dev.      915.6035
75%         1600           3087
90%         2000           3640       Variance       838329.7
95%         2100           4210       Skewness       1.065335
99%         3640           4950       Kurtosis       4.139777

. sum whrs

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
        whrs |        250      799.84    915.6035          0       4950

. kdensity whrs

. kdensity whrs, normal

**1. Regress wife’s hours of work on the number of children <6, 
*number of children between 6 & 18, wife’s age, wife’s educational attainment
. reg whrs kl6 k618 wa we

      Source |       SS           df       MS      Number of obs   =       250
-------------+----------------------------------   F(4, 245)       =      5.27
       Model |  16526046.1         4  4131511.52   Prob > F        =    0.0004
    Residual |   192218058       245    784563.5   R-squared       =    0.0792
-------------+----------------------------------   Adj R-squared   =    0.0641
       Total |   208744104       249  838329.733   Root MSE        =    885.76

------------------------------------------------------------------------------
        whrs |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         kl6 |  -462.1233   124.6768    -3.71   0.000    -707.6985   -216.5481
        k618 |    -91.141   45.85001    -1.99   0.048    -181.4515   -.8305151
          wa |   -13.1577   8.334958    -1.58   0.116    -29.57502    3.259612
          we |   53.26156   26.09369     2.04   0.042     1.864986    104.6581
       _cons |   940.0593   530.7197     1.77   0.078     -105.296    1985.415
------------------------------------------------------------------------------
* 2. Estimate the model using Tobit assuming left censoring at 0
. est store modl
. tobit whrs kl6 k618 wa we, ll(0)

Tobit regression                                Number of obs     =        250
                                                LR chi2(4)        =      23.03
                                                Prob > chi2       =     0.0001
Log likelihood = -1367.0903                     Pseudo R2         =     0.0084

------------------------------------------------------------------------------
        whrs |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         kl6 |  -827.7657   214.7407    -3.85   0.000    -1250.731   -404.8008
        k618 |  -140.0192   74.22303    -1.89   0.060    -286.2129    6.174547
          wa |  -24.97919   13.25639    -1.88   0.061    -51.08969    1.131317
          we |   103.6896   41.82393     2.48   0.014     21.31093    186.0683
       _cons |   589.0001   841.5467     0.70   0.485    -1068.556    2246.556
-------------+----------------------------------------------------------------
      /sigma |   1309.909   82.73335                      1146.953    1472.865
------------------------------------------------------------------------------
           100  left-censored observations at whrs <= 0
           150     uncensored observations
             0 right-censored observations
. est store mod2
* 3. Use OLS truncating the sample at y>0 i.e. use positive values of the dependent variable only
. regress k618 whrs kl6 wa we if whrs>0

      Source |       SS           df       MS      Number of obs   =       150
-------------+----------------------------------   F(4, 145)       =      9.55
       Model |  57.1823791         4  14.2955948   Prob > F        =    0.0000
    Residual |  217.090954       145    1.497179   R-squared       =    0.2085
-------------+----------------------------------   Adj R-squared   =    0.1867
       Total |  274.273333       149  1.84076063   Root MSE        =    1.2236

------------------------------------------------------------------------------
        k618 |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
        whrs |  -.0002392   .0001241    -1.93   0.056    -.0004845    6.05e-06
         kl6 |  -.4850234   .2565157    -1.89   0.061    -.9920162    .0219695
          wa |  -.0757706   .0132599    -5.71   0.000    -.1019784   -.0495629
          we |  -.0109706    .047279    -0.23   0.817    -.1044156    .0824745
       _cons |   5.096945     .85402     5.97   0.000     3.409009    6.784881
------------------------------------------------------------------------------

. est store mod3

*3. Use OLS truncating the sample at y>0 i.e. use positive values of the dependent variable only
. truncreg whrs kl6 k618 wa we, ll(0)
(note: 100 obs. truncated)

Fitting full model:

Iteration 0:   log likelihood = -1205.6992  
Iteration 1:   log likelihood = -1200.9873  
Iteration 2:   log likelihood = -1200.9159  
Iteration 3:   log likelihood = -1200.9157  
Iteration 4:   log likelihood = -1200.9157  

Truncated regression
Limit:   lower =          0                     Number of obs     =        150
         upper =       +inf                     Wald chi2(4)      =      10.05
Log likelihood = -1200.9157                     Prob > chi2       =     0.0395

------------------------------------------------------------------------------
        whrs |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         kl6 |  -803.0042   321.3614    -2.50   0.012    -1432.861   -173.1474
        k618 |   -172.875   88.72898    -1.95   0.051    -346.7806    1.030579
          wa |  -8.821123   14.36848    -0.61   0.539    -36.98283    19.34059
          we |   16.52873   46.50375     0.36   0.722    -74.61695    107.6744
       _cons |    1586.26    912.355     1.74   0.082    -201.9234    3374.442
-------------+----------------------------------------------------------------
      /sigma |   983.7262   94.44303    10.42   0.000     798.6213    1168.831
------------------------------------------------------------------------------

. est store mod4

. findit esttab
*need click

. esttab modl mod2 mod3 mod4, abs

----------------------------------------------------------------------------
                      (1)             (2)             (3)             (4)   
                     whrs            whrs            k618            whrs   
----------------------------------------------------------------------------
main                                                                        
kl6                -0.950**        -827.8***       -0.485          -803.0*  
                   (3.03)          (3.85)          (1.89)          (2.50)   

k618               -0.123          -140.0                          -172.9   
                   (1.10)          (1.89)                          (1.95)   

wa                -0.0389          -24.98         -0.0758***       -8.821   
                   (1.88)          (1.88)          (5.71)          (0.61)   

we                  0.175**         103.7*        -0.0110           16.53   
                   (2.68)          (2.48)          (0.23)          (0.36)   

whrs                                            -0.000239                   
                                                   (1.93)                   

_cons               0.328           589.0           5.097***       1586.3   
                   (0.25)          (0.70)          (5.97)          (1.74)   
----------------------------------------------------------------------------
sigma                                                                       
_cons                              1309.9***                        983.7***
                                  (15.83)                         (10.42)   
----------------------------------------------------------------------------
N                     250             250             150             150   
----------------------------------------------------------------------------
Absolute t statistics in parentheses
* p<0.05, ** p<0.01, *** p<0.001

. 
. esttab modl mod2 mod3 mod4 using tobitreg.rtf, label
(output written to tobitreg.rtf)
. eststo clear
. margins, dydx(*) predict(e(0,1))

Average marginal effects                        Number o
> f obs                                                 
>           =        250
Model VCE    : OIM

Expression   : E(whrs|0<whrs<1), predict(e(0,1))
dy/dx w.r.t. : kl6 k618 wa we

--------------------------------------------------------
> ----------------------
             |            Delta-method
             |      dy/dx   Std. Err.      z    P>|z|   
>   [95% Con                                            
>           f. Interval]
-------------+------------------------------------------
> ----------------------
         kl6 |  -.0000401   .0000104    -3.86   0.000   
>  -.0000605                                            
>              -.0000197
        k618 |  -6.78e-06   3.59e-06    -1.89   0.059   
>  -.0000138                                                          2.59e-07
          wa |  -1.21e-06   6.42e-07    -1.89   0.059    -2.47e-06    4.80e-08
          we |   5.02e-06   2.03e-06     2.48   0.013     1.05e-06    8.99e-06
------------------------------------------------------------------------------

. . margins, dydx(*) predict(e(0,1))

Average marginal effects                        Number o
> f obs                                                 
>           =        250
Model VCE    : OIM

Expression   : E(whrs|0<whrs<1), predict(e(0,1))
dy/dx w.r.t. : kl6 k618 wa we

--------------------------------------------------------
> ----------------------
             |            Delta-method
             |      dy/dx   Std. Err.      z    P>|z|   
>   [95% Con                                            
>           f. Interval]
-------------+------------------------------------------
> ----------------------
         kl6 |  -.0000401   .0000104    -3.86   0.000   
>  -.0000605                                            
>              -.0000197
        k618 |  -6.78e-06   3.59e-06    -1.89   0.059   
>  -.0000138                                                          2.59e-07
          wa |  -1.21e-06   6.42e-07    -1.89   0.059    -2.47e-06    4.80e-08
          we |   5.02e-06   2.03e-06     2.48   0.013     1.05e-06    8.99e-06
------------------------------------------------------------------------------

. margins, dydx(*) predict(e(0,1))

Average marginal effects                        Number of obs     =        250
Model VCE    : OIM

Expression   : E(whrs|0<whrs<1), predict(e(0,1))
dy/dx w.r.t. : kl6 k618 wa we

------------------------------------------------------------------------------
             |            Delta-method
             |      dy/dx   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         kl6 |  -.0000401   .0000104    -3.86   0.000    -.0000605   -.0000197
        k618 |  -6.78e-06   3.59e-06    -1.89   0.059    -.0000138    2.59e-07
          wa |  -1.21e-06   6.42e-07    -1.89   0.059    -2.47e-06    4.80e-08
          we |   5.02e-06   2.03e-06     2.48   0.013     1.05e-06    8.99e-06
------------------------------------------------------------------------------

. 

