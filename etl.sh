#!/usr/bin/sh

# EXTRACT

echo "Extracting Data"

# Variables
URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

Folder="raw"
File_Name="Enterprise_Survey.csv"
File_Copy="Copy_Survey.csv"
New_File="2023_year_finance.csv"
New_Dir="Transformed"
Load_Dir="load"

# Create directories
mkdir -p "$Folder"
mkdir -p "$New_Dir"
mkdir -p "$Load_Dir"

# Download the file
curl -L "$URL" -o "$Folder/$File_Name"

if [ $? -eq 0 ]; then
    echo "Download completed! File saved to $Folder/$File_Name"
else
    echo "Download failed!"
    exit 1
fi



# COPY ORIGINAL FILE BEFORE TRANSFORMATION

echo "Checking downloaded file..."
ls -lh "$Folder/$File_Name"

echo "Creating backup copy..."

cp "$Folder/$File_Name" "$Folder/$File_Copy"

if [ $? -eq 0 ]; then
    echo "Backup copy created successfully: $Folder/$File_Copy"
else
    echo "ERROR: Failed to create backup copy!"
    exit 1
fi

# TRANSFORM

echo "Renaming column"

sed '1s/Variable_code/variable_code/' \
    "$Folder/$File_Copy" \
    > "$Folder/temp_survey.csv"

if [ $? -eq 0 ]; then
    echo "Column renamed successfully"
else
    echo "Column rename failed!"
    exit 1
fi

# Replace the original copy with the transformed version
mv "$Folder/temp_survey.csv" "$Folder/$File_Copy"


echo "Selecting required columns"

csvcut -c Year,Value,Units,variable_code \
    "$Folder/$File_Copy" \
    > "$New_Dir/$New_File"

if [ $? -eq 0 ]; then
    echo "Selected columns successfully"
    echo "Transformed file saved to $New_Dir/$New_File"
else
    echo "Column selection failed!"
    exit 1
fi


# LOAD

echo "Data Loading step"

cp "$New_Dir/$New_File" "$Load_Dir/$New_File"

if [ $? -eq 0 ]; then
    echo "Data loaded successfully to $Load_Dir/$New_File"
else
    echo "Data loading failed!"
    exit 1
fi

echo "ETL process completed successfully!"
