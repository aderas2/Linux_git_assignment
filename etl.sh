#!/usr/bin/sh


# Extracting the data from the URL

echo "Extracting Data"

# Defining the variables

URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"
Folder="raw"
File_Name="Enterprise_Survey.csv"
File_Copy="Copy_Survey.csv"


#creating the destination directory

mkdir -p "$Folder"

#Downloading the file using the URL

curl -L "$URL" -o "$Folder/$File_name"

echo 'Download completed! Fild saved to "$Folder/$File_name" '


# Creating a copy of the file before Data Transformation
cp "$File_Name" ./"$File_Copy"

# Transforming the Data

echo "Renaming column"

sed '1s/Variable_code/variable_code' "$File_Copy"

echo
