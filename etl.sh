#!/usr/bin/sh


echo "Extracting Data"

export CSV_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"
export Folder="./raw"

curl -l  CSV_URL >  Folder/raw.csv &  echo "Downloaded Successfully"


