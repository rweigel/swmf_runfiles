#ECHO
T

#DESCRIPTION
"In the pipes" simulation set up.

#TIMEACCURATE
F                       DoTimeAccurate

#IDEALAXES

#STARTTIME
2000            year
09              month
22              day
00              hour
00              minute
00              second
0.0             FracSecond

#COMPONENT
IM                      NameComp
F                       UseComp

#COMPONENT
PW
F

#COUPLE2
GM                      NameComp1
IE                      NameComp2
10                      DnCouple
-1.0                    DtCouple

#BEGIN_COMP GM ---------------------------------------------------------------

#GRID
1			nRootBlock_D(x_)
1			nRootBlock_D(y_)
1			nRootBlock_D(z_)
-224.			x1
 32.			x2
-128.			y1
 128.			y2
-128.			z1
 128.			z2

! Maximum resolution initially
#GRIDRESOLUTION
1.0			Resolution
initial			NameArea

! Minimum resolution in the computational domain
#GRIDRESOLUTION
8.0			Resolution
all			NameArea

! Far tail for wind satellite and inflow
#GRIDRESOLUTION
1.0			Resolution
box			NameArea
-100.0			xMinBox
 -16.0			yMinBox
 -16.0			zMinBox
  32.0			xMaxBox
  16.0			yMaxBox
  16.0			xMaxBox

! Super high at inner boundary
! to capture outflow patterns.
#GRIDRESOLUTION
1/16
box
-4.0                   xMinBox
-4.0                   yMinBox
-4.0                   zMinBox
 4.0                   xMaxBox
 4.0                   yMaxBox
 4.0                   zMaxBox

! Strong resolution just outside
! super-hi for clean outflow.
#GRIDRESOLUTION
1/8
box
-8.0                   xMinBox
-8.0                   yMinBox
-8.0                   zMinBox
 8.0                   xMaxBox
 8.0                   yMaxBox
 8.0                   zMaxBox

! Good res throughout lobes.
#GRIDRESOLUTION
1/4
box
-32.0                  xMinBox
-16.0                   yMinBox
-16.0                   zMinBox
 12.0                   xMaxBox
 16.0                   yMaxBox
 16.0                   zMaxBox

! 1/2 RE buffer around inner mag.
#GRIDRESOLUTION
1/2			Resolution
box			NameArea
-40.0			xMinBox
-24.0			yMinBox
-24.0			zMinBox
 24.0			xMaxBox
 24.0			yMaxBox
 24.0			zMaxBox

#BODY
T                       body1
2.5                     Rbody
3.0                     Rcurrents
10.0                    Magneto_rho_dim (/ccm) density H+
0.1                     Magneto_rho_dim (/ccm) density O+
25000.0                 Magneto_T_dim (K) temperature for fixed BC for P_BLK

#NONCONSERVATIVE
T                       UseNonConservative

#CONSERVATIVECRITERIA
1			nConservCrit
parabola		TypeConservCrit_I
 5.0			xParabolaConserv
15.0			yParabolaConserv

#TVDRESCHANGE
T

#TIMESTEPPING
1			nStage
0.80			CflExlp

#OUTERBOUNDARY
outflow			TypeBC_I(east_)
vary			TypeBC_I(west_)
float			TypeBC_I(south_)
float			TypeBC_I(north_)
float			TypeBC_I(bot_)
float			TypeBC_I(top_)

#INNERBOUNDARY
ionosphere		

#SCHEME
1			nOrder
Rusanov			TypeFlux

#SAVEPLOTSAMR
F			DoSavePlotsAmr to save plots before each AMR

#AMR
100			DnRefine
F			DoAutomaticRefinement 

#UPSTREAM_INPUT_FILE
T                       UseUpstreamInputFile
IMF.dat                 UpstreamFileName
0.0                     Satellite_Y_Pos
0.0                     Satellite_Z_Pos

#END_COMP GM -----------------------------------------------------------------

#BEGIN_COMP IE ---------------------------------------------------------------

#IONOSPHERE
5                       TypeConductanceModel
F                       UseFullCurrent
F                       UseFakeRegion2
200.0                   F107Flux
1.0                     StarLightPedConductance
0.25                    PolarCapPedConductance

#BOUNDARY
10.0			LatBoundary

#AURORALOVAL
T			UseOval (rest of parameters read if true)
T			UseOvalShift
F			UseSubOvalConductance
T			UseAdvancedOval
F			DoFitCircle (read if UseAdvancedOval is true)

#END_COMP IE -----------------------------------------------------------------

#STOP
2000                     MaxIter
-1.                     TimeMax

#RUN    ######################################################################

#BEGIN_COMP GM ---------------------------------------------------------------

#SAVERESTART                                                     
T                       DoSaveRestart
1000                      DnSaveRestart
-1                  DtSaveRestart

#AMR
-1			DnRefine

#SCHEME
2			nORDER
Rusanov			TypeFlux
mc3                     TypeLimiter
1.2

#TIMESTEPPING
2			nStage
0.60			CflExlp

#BORIS
T
0.02

#END_COMP GM -----------------------------------------------------------------

#STOP
8000                    MaxIter
-1.                     TimeMax
