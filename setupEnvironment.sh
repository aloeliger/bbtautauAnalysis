#!/usr/bin/bash

#Andrew Loeliger
#script for setting up the necessary CMSSW releases and releases for signal production 
#and hopefully eventually for complete analysis chains

scram pro CMSSW CMSSW_10_6_25
cd CMSSW_10_6_25/src/
cmsenv
git cms-init

cd ../../

scram pro CMSSW CMSSW_8_0_33_UL
cd CMSSW_8_0_33_UL/src/
cmsenv
git cms-init

cd ../../

scram pro CMSSW CMSSW_10_2_13
cd CMSSW_10_2_13/src/
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
cmsenv
git cms-addpkg PhysicsTools/NanoAOD/
git clone --recursive git@github.com:aloeliger/bbtautauAnalysisScripts.git
#git clone https://github.com/cms-nanoAOD/nanoAOD-tools.git PhysicsTools/NanoAODTools
git clone https://github.com/SVfit/ClassicSVfit TauAnalysis/ClassicSVfit -b fastMTT_19_02_2019
git clone https://github.com/SVfit/SVfitTF TauAnalysis/SVfitTF
git clone git@github.com:aloeliger/nanoAOD-tools.git PhysicsTools/NanoAODTools
scram b -j 8
cd ../../

cd CMSSW_8_0_33_UL/src/
cmsenv
scram b -j 8
cd ../../

cd CMSSW_10_2_13/src/
cmsenv
git clone https://github.com/cms-analysis/HiggsAnalysis-CombinedLimit.git HiggsAnalysis/CombinedLimit
git clone https://github.com/cms-analysis/CombineHarvester.git CombineHarvester
scram b -j 8
cd ../../
