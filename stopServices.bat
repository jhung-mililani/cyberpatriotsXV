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
set servicesStopList=PlugPlay Spooler
set servicesStartList=
set windowsUpdateServices=wuauserv

:: This function uses the Service Control Manager to stop the service that is passed through it as a parameter. 
:stopService 
sc stop %~1
if ERRORLEVEL 1 echo Unable to stop %~1. Check to see if it is already stopped. 
   pause 
exit /b 0 

:: This function uses the Service Control Manager to disable the service that is passed through it as a parameter. 
:disableService 
sc config %~1 start=disabled
if ERRORLEVEL 1 echo Unable to disable %~1. Check to see if it is already disabled. 
   pause 
exit /b 0 

:: This function uses the Service Control Manager to start the service that is passed through it as a parameter. 
:startService 
sc start %~1 
if ERRORLEVEL 1 echo Unable to start %~1. Check to see if it is already started. 
   pause 
exit /b 0 

:: This loop iterates over the given array and stops and disables those services. TODO: make array mutable by prompting user. 
for %%i in (%servicesStopList%) do (
   call :stopService %servicesStopList%[%%i] 
   call :disableService %servicesStopList%[%%i]
) 

cmd /k 
