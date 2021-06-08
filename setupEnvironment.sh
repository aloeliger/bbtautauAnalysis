#!/usr/bin/bash

#Andrew Loeliger
#script for setting up the necessary CMSSW releases and releases for signal production 
#and hopefully eventually for complete analysis chains

scram pro CMSSW CMSSW_10_6_20
cd CMSSW_10_6_20/src/
cmsenv
git cms-init

cd ../../

scram pro CMSSW CMSSW_8_0_33_UL
cd CMSSW_8_0_33_UL/src/
cmsenv
git cms-init

cd ../../

cd CMSSW_10_6_25/src/
cmsenv
git cms-addpkg Configuration/Generator
scram b -j 8
cd ../../

mkdir CMSSW_10_6_25/src/signalProductionWorkspace
cp -r signalProduction/python/ CMSSW_10_6_25/src/signalProductionWorkspace/
cp signalProduction/python/2016/generator_fragment/bbtautau_fragment_2016.py CMSSW_10_6_25/src/Configuration/Generator/python/

mkdir CMSSW_8_0_33_UL/src/signalProductionWorkspace
cp -r signalProduction/python/ CMSSW_8_0_33_UL/src/signalProductionWorkspace/

cd CMSSW_10_6_25/src/
#checkout out some outher useful things
git cms-addpkg PhysicsTools/NanoAOD/
git clone git@github.com:aloeliger/bbtautauAnalysisScripts.git
cmsenv
scram b -j 8
cd ../../

cd CMSSW_8_0_33_UL/src/
cmsenv
scram b -j 8
cd ../../
