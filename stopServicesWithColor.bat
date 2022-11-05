::========================================================================
:: Code by: 
::        _ __                                      _ ___ __            _ 
::       (_) /_  __  ______  ____ _      ____ ___  (_) (_) /___ _____  (_)
::      / / __ \/ / / / __ \/ __ `/_____/ __ `__ \/ / / / / __ `/ __ \/ / 
::     / / / / / /_/ / / / / /_/ /_____/ / / / / / / / / / /_/ / / / / /  
::  __/ /_/ /_/\__,_/_/ /_/\__, /     /_/ /_/ /_/_/_/_/_/\__,_/_/ /_/_/   
:: /___/                  /____/                                          
::======================================================================== 

@echo off
set servicesList=PlugPlay Spooler

:stopService 


for %%i in (%servicesList%) do (
   sc stop %%i 
   if ERRORLEVEL 1 echo Unable to stop %%i. Check to see if it is already stopped. 
   pause 
   sc config %%i start=disabled 
   if ERRORLEVEL 1 echo Unable to disable %%i. Check to see if it is already disabled. 
   pause 
) 

cmd /k 
