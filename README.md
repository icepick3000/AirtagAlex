# AirtagAlex

!!This script will NOT work on MAC's that have a Sonoma version thats newer then 14.3.1. Apple started encrypting the data after this version!!

Get all metadata from the Airtags (lat, lon, geocoding information, precision range, battery status).
This script is a very basic script to write the data to a CSV for processing in Excel or Numbers. I am sure many rewrites will be done by other folks but anyone with some programming experience will have a good starting point with this script. 

Click below to see the youtube video and a step by step guide;

[![Click here for the youtube video](https://img.youtube.com/vi/9VQ-_ztG9aM/0.jpg)](https://www.youtube.com/watch?v=9VQ-_ztG9aM)


## Instructions

* Install brew (https://brew.sh/)
* Install the jq utility (`brew install jq`)
* Clone this repo by typing `git clone https://github.com/icepick3000/AirtagAlex.git`
* Make the shell file executable by typing `chmod 700 AirtagAlex.sh`
  
You can start the script by typing:
  
`./AirtagAlex.sh`
  
The output will look something like this:

```
Create a copy of the Items.data file to prevent changes while the script is running
Check if Airtags.csv exists
Check how many Airtags to process
Number of Airtags to process:       4
Processing airtag number 0
Write the data to the Airtags.csv file
Processing airtag number 1
Write the data to the Airtags.csv file
Processing airtag number 2
Write the data to the Airtags.csv file
Processing airtag number 3
Write the data to the Airtags.csv file
Sleep for 1 minute (60 seconds)
```
  
The results in CSV format can be found in the same directory!
    
To see all my Airtag adventures check out my channel at https://www.youtube.com/c/AirtagAlex
    
If this script was of use to you a referal in your video or project would be highly appreciated. 

## Troubleshooting
If you receive an `operation not permitted` error when running the script, please ensure that `Terminal` has `Full Disk Access` in the `Privacy & Security` settings in macOS.

This is because of the file permissions on the `Items.data` file. Please propose an alternative or better way to do this if it's possible.
