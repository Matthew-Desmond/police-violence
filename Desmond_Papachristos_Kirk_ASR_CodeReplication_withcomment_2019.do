/*******************************************************************************
Code for models used in the following articles (original and 2019 comment):

Desmond, MS, AV Papachristos, and DS Kirk. 2016. "Police Violence and 
Citizen Crime Reporting in the Black Community." American Sociological 
Review 81:857-876.

Desmond, MS, AV Papachristos, and DS Kirk. 2019. "Evidence of the Effect 
of Police Violence on Citizen Crime Reporting." American Sociological Review. 
Forthcoming.

Includes analyses of Frank Jude case, but omits supplementary analyses 
*******************************************************************************/



use "J:\research\DesmondetalASR2016_ReplicationData.dta", clear

* Note: For privacy protection and per data agreement with Milwaukee PD, the block group identifiers in the data are scrambled.

*** declare dataset to be time series
xtset scramble_bg weekssincejan04

*********************************

** Table 2 (Frank Jude) **
* All Neighborhoods (Total Calls and Violent Calls)*
xtnbreg total_call weekssincejan04 i.post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)
xtnbreg vc_call weekssincejan04 i.post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month vc perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)

* Black Neighborhoods *
xtnbreg total_call weekssincejan04 i.post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8 & blacknhood==1, fe exposure(pop)
xtnbreg vc_call weekssincejan04 i.post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month vc perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8 & blacknhood==1, fe exposure(pop)

* White Neighborhoods *
xtnbreg total_call weekssincejan04 i.post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8 & whitenhood==1, fe exposure(pop)
xtnbreg vc_call weekssincejan04 i.post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month vc perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8 & whitenhood==1, fe exposure(pop)



*********************************

** Table 3 (Auto Accidents) **
* First model is the best fit, included in ASR paper, linear pre and post
xtnbreg accident c.weekssincejan04 post_story c.weeks_since_storyjudew_rev i.month perpov perrenter perblack perlatino prcp snow if weekssincejan04>=8 & weekssincejan04<=99 , fe exposure(pop)
estat ic
* Estimated models to assess fit, results not included in ASR paper
* Linear pre and quadratic post
xtnbreg accident c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month perpov perrenter perblack perlatino prcp snow if weekssincejan04>=8 & weekssincejan04<=99 , fe exposure(pop)
estat ic
* Quadratic pre and linear post
xtnbreg accident c.weekssincejan04##c.weekssincejan04 post_story weeks_since_storyjudew_rev i.month perpov perrenter perblack perlatino prcp snow if weekssincejan04>=8 & weekssincejan04<=99 , fe exposure(pop)
estat ic
* Quadratic pre and quadratic post
xtnbreg accident c.weekssincejan04##c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month perpov perrenter perblack perlatino prcp snow if weekssincejan04>=8 & weekssincejan04<=99 , fe exposure(pop)
estat ic

*********************************


** Appendix Table A1 **
** Model fit, comparing linear and quadratic specifications **
* Linear pre-Jude, Linear Post-Jude
xtnbreg total_call weekssincejan04 post_story weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)
estat ic
xtnbreg vc_call weekssincejan04 post_story weeks_since_storyjudew_rev i.month vc perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)
estat ic
* Linear pre-Jude, Linear and Quadratic Post-Jude
xtnbreg total_call weekssincejan04 post_story weeks_since_storyjudew_rev weeks_since_storyjudew_sq_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)
estat ic
xtnbreg vc_call weekssincejan04 post_story weeks_since_storyjudew_rev weeks_since_storyjudew_sq_rev i.month vc perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)
estat ic
* Linear and Quadratic pre-Jude, Linear Post-Jude
xtnbreg total_call weekssincejan04 weekssincejan04_sq post_story weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)
estat ic
xtnbreg vc_call weekssincejan04 weekssincejan04_sq post_story weeks_since_storyjudew_rev i.month vc perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)
estat ic
* Linear and Quadratic pre-Jude, Linear and Quadratic Post-Jude
xtnbreg total_call weekssincejan04 weekssincejan04_sq  post_story weeks_since_storyjudew_rev weeks_since_storyjudew_sq_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)
estat ic
xtnbreg vc_call weekssincejan04 weekssincejan04_sq post_story weeks_since_storyjudew_rev weeks_since_storyjudew_sq_rev i.month vc perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)
estat ic



*********************************

** Figure 2 **

*** JUDE, code for predicted count 
*Code runs the main model and outputs the margins at different weeks, 52 weeks before to 52 weeks after the story broek
xtnbreg total_call weekssincejan04 i.post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)
* predict predict_total, nu0 // saves prediction of number of calls
* pre-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(5(1)56) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend
*treatment, post-Jude
local i=56
forvalues k = 1/53 {
	local i=`i'+`k'
	margins, predict(nu0) atmeans at(weekssincejan04=`i' weeks_since_storyjudew_rev = `k'  post_story= 1 ) noatlegend
	local i = `i'-`k' 
}
*coounterfactual, post-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(57(1)109) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend



*********************************

** Figure 3 **

* Total Calls, Black neighborhoods
xtnbreg total_call weekssincejan04 i.post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8 & blacknhood==1, fe exposure(pop)
* pre-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(5(1)56) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend
*treatment, post-Jude
local i=56
forvalues k = 1/53 {
	local i=`i'+`k'
	margins, predict(nu0) atmeans at(weekssincejan04=`i' weeks_since_storyjudew_rev = `k'  post_story= 1 ) noatlegend
	local i = `i'-`k' 
}
*coounterfactual, post-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(57(1)109) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend


* Total Calls, White neighborhoods
xtnbreg total_call weekssincejan04 i.post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8 & whitenhood==1, fe exposure(pop)
* pre-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(5(1)56) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend
*treatment, post-Jude
local i=56
forvalues k = 1/53 {
	local i=`i'+`k'
	margins, predict(nu0) atmeans at(weekssincejan04=`i' weeks_since_storyjudew_rev = `k'  post_story= 1 ) noatlegend
	local i = `i'-`k' 
}
*coounterfactual, post-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(57(1)109) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend





***************************************************************************************************************************
* ZOOROB REPLICATION AND RESPONSE
***************************************************************************************************************************

***************
*** TABLE 1 ***
***************

* Original DPK findings (Model 1)
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8, fe exposure(pop)
* Zoorob model, remove outlier week 103 (Model 2)
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if year<=2005 & weekssincejan04>8 & weekssincejan04!=103, fe exposure(pop)
* output margins for weeks 9 to 102 (48 weeks before to 45 post, per Zoorob)
* pre-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(9(1)56) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend
*treatment, post-Jude
local i=56
forvalues k = 1/46 {
	local i=`i'+`k'
	margins, predict(nu0) atmeans at(weekssincejan04=`i' weeks_since_storyjudew_rev = `k'  post_story= 1 ) noatlegend
	local i = `i'-`k' 
}
*coounterfactual, post-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(57(1)102) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend


*********************************************************************************************************************************
* Add control for temperature (Excludes last week fo 2005, per Zoorob); tmax is the avg MAX daily temp in a given week
*Lowest AIC is linear pre-Jude and quadratic post-Jude (Model 3)
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino tmax if year<=2005 & weekssincejan04>8 & weekssincejan04!=103, fe exposure(pop)
estat ic 
*Lowest BIC is linear pre-Jude and linear post=Jude (Model 4)
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino tmax if year<=2005 & weekssincejan04>8 & weekssincejan04!=103, fe exposure(pop)
estat ic 

*** Also estimate other combos of linear and quadratic
*quad/lin
xtnbreg total_call c.weekssincejan04##c.weekssincejan04 post_story c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino tmax if year<=2005 & weekssincejan04>8 & weekssincejan04!=103, fe exposure(pop)
estat ic  // 4th best per AIC, 3rd best per BIC
*quad/quad
xtnbreg total_call c.weekssincejan04##c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino tmax if year<=2005 & weekssincejan04>8 & weekssincejan04!=103, fe exposure(pop)
estat ic // 2nd best fit per AIC, 4th best per BIC


*** Margins for Model 3 ***
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino tmax if year<=2005 & weekssincejan04>8 & weekssincejan04!=103, fe exposure(pop)
* pre-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(9(1)56) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend
*treatment, post-Jude
local i=56
forvalues k = 1/46 {
	local i=`i'+`k'
	margins, predict(nu0) atmeans at(weekssincejan04=`i' weeks_since_storyjudew_rev = `k'  post_story= 1 ) noatlegend
	local i = `i'-`k' 
}
*coounterfactual, post-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(57(1)102) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend


*** Margins for Model 4 ***
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino tmax if year<=2005 & weekssincejan04>8 & weekssincejan04!=103, fe exposure(pop)
* pre-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(9(1)56) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend
*treatment, post-Jude
local i=56
forvalues k = 1/46 {
	local i=`i'+`k'
	margins, predict(nu0) atmeans at(weekssincejan04=`i' weeks_since_storyjudew_rev = `k'  post_story= 1 ) noatlegend
	local i = `i'-`k' 
}
*coounterfactual, post-Jude
margins, predict(nu0) atmeans at(weekssincejan04=(57(1)102) weeks_since_storyjudew_rev = 0 post_story= 0 ) noatlegend




***************
*** TABLE 2 ***
***************

* DOES NOT INCLUDE CONTROL FOR TEMP *
*** 20 weeks  
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if weekssincejan04>8 & weekssincejan04<=77, fe exposure(pop)

*** 40 weeks  
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if weekssincejan04>8 & weekssincejan04<=97, fe exposure(pop)

*** 60 weeks 
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino if weekssincejan04>8 & weekssincejan04<=117 & weekssincejan04!=103, fe exposure(pop)


***************
*** TABLE A1 ***
***************

* SIMILAR TO TABLE 2, BUT ADD CONTROL FOR TEMP AND SAME NUMBER OF WEEKS IN PRE AND POST PERIOD (EXCEPT WEEKS = 60) *
*** 20 weeks  
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino tmax if weekssincejan04>=37 & weekssincejan04<=77, fe exposure(pop)

*** 40 weeks  
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino tmax if weekssincejan04>=17 & weekssincejan04<=97, fe exposure(pop)

*** 60 weeks 
xtnbreg total_call c.weekssincejan04 post_story c.weeks_since_storyjudew_rev##c.weeks_since_storyjudew_rev i.month total_crime perpov perrenter perblack perlatino tmax if weekssincejan04>8 & weekssincejan04<=117 & weekssincejan04!=103, fe exposure(pop)
