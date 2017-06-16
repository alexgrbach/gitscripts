#!/bin/bash

cd /c/git/AmtFormBaseLib
git checkout --quiet Builds/2.0.9.0 
cd /c/git/UniversalBillingEngine
git checkout --quiet develop 
cd /c/git/DLL-CryptKeeper/
git checkout --quiet master 
cd /c/git/FormsIssuance
git checkout --quiet develop 
cd /c/git/DLL-GrandCentral/
git checkout --quiet master 
cd /c/git/DLL-GrandCentralModels/
git checkout --quiet master 
cd /c/git/HOUtilities/
git checkout --quiet develop 
cd /c/git/HOMVC/
git checkout --quiet develop 
cd /c/git/HOModels
git checkout --quiet develop 
cd /c/git/HORatingData
git checkout --quiet develop 
cd /c/git/HO
git checkout --quiet develop 
cd /c/git/NGIC.Libraries
git checkout --quiet master 
cd /c/git/PL.Contract.Preferred
git checkout --quiet master 
cd /c/git/PL.Domain
git checkout --quiet master 
cd /c/git/PolicyManagement
git checkout --quiet develop 
cd /c/git/NGIC.HO.RatingEngine
git checkout --quiet develop 
cd /c/git/NGIC.HO.RulesEngine/
git checkout --quiet develop 