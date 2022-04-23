#!/bin/bash

#AirtagAlex.sh script to capture Airtag locations on a macosx device
#For more info: https://github.com/icepick3000/AirtagAlex
#Or visit my youtube channel: https://www.youtube.com/channel/UCyotIQ11MKrLDFdJCXhZjwA



#Start an infinite loop
while :
do


	echo "Create a copy of the Items.data file to prevent changes while the script is running"
	cp -pr ~/Library/Caches/com.apple.findmy.fmipcore/Items.data ~/Desktop/Airtags/Items.data

	echo "Check if Airtags.csv exists"
	if [ ! -f ~/Desktop/Airtags/Airtags.csv ]
	then
	echo "Airtags.csv does not exist, creating one"
	#Header for the CSV file (currently set up to append to the file)
	echo datetime,name,serialnumber,producttype,productindentifier,vendoridentifier,antennapower,systemversion,batterystatus,locationpositiontype,locationlatitude,locationlongitude,locationtimestamp,locationverticalaccuracy,locationhorizontalaccuracy,locationfloorlevel,locationaltitude,locationisinaccurate,locationisold,locationfinished,addresslabel,addressstreetaddress,addresscountrycode,addressstatecode,addressadministrativearea,addressstreetname,addresslocality,addresscountry,addressareaofinteresta,addressareaofinterestb,batterystatus >> ~/Desktop/Airtags/Airtags.csv
	fi


	echo "Check how many Airtags to process"
	airtagsnumber=`cat ~/Desktop/Airtags/Items.data | jq ".[].serialNumber" | wc -l`
	echo "Number of Airtags to process: $airtagsnumber"
	airtagsnumber=`echo "$(($airtagsnumber-1))"`

	for j in $(seq 0 $airtagsnumber)
	do
	echo Processing airtag number $j

	datetime=`date +"%Y-%m-%d  %T"`

	serialnumber=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].serialNumber"`
	name=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].name"`
	producttype=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].productType.type"`
	productindentifier=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].productType.productInformation.productIdentifier"`
	vendoridentifier=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].productType.productInformation.vendorIdentifier"`
	antennapower=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].productType.productInformation.antennaPower"`
	systemversion=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].systemVersion"`
	batterystatus=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].batteryStatus"`
	locationpositiontype=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].location.positionType"`
	locationlatitude=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].location.latitude"`
	locationlongitude=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].location.longitude"`
	locationtimestamp=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].location.timeStamp"`
	locationverticalaccuracy=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].location.verticalAccuracy" | sed 's/null/0/g'`
	locationhorizontalaccuracy=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].location.horizontalAccuracy" | sed 's/null/0/g'`
	locationfloorlevel=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].location.floorlevel" | sed 's/null/0/g'`
	locationaltitude=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].location.altitude" | sed 's/null/0/g'`
	locationisinaccurate=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].location.isInaccurate" | awk '{ print "\""$0"\"" }'`
	locationisold=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].location.isOld" | awk '{ print "\""$0"\"" }' `
	locationfinished=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].location.locationFinished" | awk '{ print "\""$0"\"" }' `
	addresslabel=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].address.label" | sed 's/null/""/g'`
	addressstreetaddress=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].address.streetAddress"| sed 's/null/""/g'`
	addresscountrycode=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].address.countryCode"| sed 's/null/""/g'`
	addressstatecode=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].address.stateCode" | sed 's/null/""/g'`
	addressadministrativearea=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].address.administrativeArea"| sed 's/null/""/g'`
	addressstreetname=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].address.streetName"| sed 's/null/""/g'`
	addresslocality=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].address.locality"| sed 's/null/""/g'`
	addresscountry=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].address.country"| sed 's/null/""/g'`
	addressareaofinteresta=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].address.areaOfInterest[0]" | sed 's/null/""/g'`
	addressareaofinterestb=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].address.areaOfInterest[1]" | sed 's/null/""/g'`
	batterystatus=`cat ~/Desktop/Airtags/Items.data | jq ".[$j].batteryStatus"`

	echo "Write the data to the Airtags.csv file"

	echo $datetime,$name,$serialnumber,$producttype,$productindentifier,$vendoridentifier,$antennapower,$systemversion,$batterystatus,$locationpositiontype,$locationlatitude,$locationlongitude,$locationtimestamp,$locationverticalaccuracy,$locationhorizontalaccuracy,$locationfloorlevel,$locationaltitude,$locationisinaccurate,$locationisold,$locationfinished,$addresslabel,$addressstreetaddress,$addresscountrycode,$addressstatecode,$addressadministrativearea,$addressstreetname,$addresslocality,$addresscountry,$addressareaofinteresta,$addressareaofinterestb,$batterystatus >> ~/Desktop/Airtags/Airtags.csv


	done
	echo "Sleep for 1 minute (60 seconds)"
	sleep 60

done

