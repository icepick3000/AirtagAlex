#!/bin/bash

ITEMS_FILE="./Items.data"
CSV_FILE="./Airtags.csv"
CSV_HEADER="datetime,name,serialnumber,producttype,productindentifier,vendoridentifier,antennapower,systemversion,batterystatus,locationpositiontype,locationlatitude,locationlongitude,locationtimestamp,locationverticalaccuracy,locationhorizontalaccuracy,locationfloorlevel,locationaltitude,locationisinaccurate,locationisold,locationfinished,addresslabel,addressstreetaddress,addresscountrycode,addressstatecode,addressadministrativearea,addressstreetname,addresslocality,addresscountry,addressareaofinteresta,addressareaofinterestb"

copy_items_data() {
	echo "Creating a copy of Items.data to prevent potential file corruption"
	if ! cp -p ~/Library/Caches/com.apple.findmy.fmipcore/Items.data "$ITEMS_FILE"; then
	    echo "Failed to copy Items.data file. Please ensure Terminal has 'Full Disk Access' in the 'Privacy & Security' section in macOS Preferences" >&2
	    exit 1
	fi
}

create_csv_file() {
	echo "Checking if $CSV_FILE exists"
	if [ ! -f "$CSV_FILE" ]; then
	    echo "$CSV_FILE does not exist, creating one"
	    if ! echo "$CSV_HEADER" >> "$CSV_FILE"; then
	        echo "Failed to create $CSV_FILE. Please ensure the destination directory is writable." >&2
	        exit 1
	    fi
	fi
}

while true; do
	copy_items_data
	create_csv_file

	echo "Checking number of Airtags to process"
	airtagsnumber=$(jq ".[].serialNumber" "$ITEMS_FILE" | wc -l)
	echo "Number of Airtags to process: $airtagsnumber"
	airtagsnumber=$((airtagsnumber-1))

	for j in $(seq 0 "$airtagsnumber"); do
	echo "Processing airtag number $j"

	datetime=$(date +"%Y-%m-%d  %T")

	serialnumber=$(jq ".[$j].serialNumber" "$ITEMS_FILE")
	name=$(jq ".[$j].name" "$ITEMS_FILE")
	producttype=$(jq ".[$j].productType.type" "$ITEMS_FILE")
	productindentifier=$(jq ".[$j].productType.productInformation.productIdentifier" "$ITEMS_FILE")
	vendoridentifier=$(jq ".[$j].productType.productInformation.vendorIdentifier" "$ITEMS_FILE")
	antennapower=$(jq ".[$j].productType.productInformation.antennaPower" "$ITEMS_FILE")
	systemversion=$(jq ".[$j].systemVersion" "$ITEMS_FILE")
	batterystatus=$(jq ".[$j].batteryStatus" "$ITEMS_FILE")
	locationpositiontype=$(jq ".[$j].location.positionType" "$ITEMS_FILE")
	locationlatitude=$(jq ".[$j].location.latitude" "$ITEMS_FILE")
	locationlongitude=$(jq ".[$j].location.longitude" "$ITEMS_FILE")
	locationtimestamp=$(jq ".[$j].location.timeStamp" "$ITEMS_FILE")
	locationverticalaccuracy=$(jq ".[$j].location.verticalAccuracy // 0" "$ITEMS_FILE")
	locationhorizontalaccuracy=$(jq ".[$j].location.horizontalAccuracy // 0" "$ITEMS_FILE")
	locationfloorlevel=$(jq ".[$j].location.floorlevel // 0" "$ITEMS_FILE")
	locationaltitude=$(jq ".[$j].location.altitude // 0" "$ITEMS_FILE")
	locationisinaccurate=$(jq ".[$j].location.isInaccurate" "$ITEMS_FILE" | awk '{ print "\""$0"\"" }')
	locationisold=$(jq ".[$j].location.isOld" "$ITEMS_FILE" | awk '{ print "\""$0"\"" }' )
	locationfinished=$(jq ".[$j].location.locationFinished" "$ITEMS_FILE" | awk '{ print "\""$0"\"" }' )
	addresslabel=$(jq ".[$j].address.label // \"\"" "$ITEMS_FILE")
	addressstreetaddress=$(jq ".[$j].address.streetAddress // \"\"" "$ITEMS_FILE")
	addresscountrycode=$(jq ".[$j].address.countryCode // \"\"" "$ITEMS_FILE")
	addressstatecode=$(jq ".[$j].address.stateCode // \"\"" "$ITEMS_FILE")
	addressadministrativearea=$(jq ".[$j].address.administrativeArea // \"\"" "$ITEMS_FILE")
	addressstreetname=$(jq ".[$j].address.streetName // \"\"" "$ITEMS_FILE")
	addresslocality=$(jq ".[$j].address.locality // \"\"" "$ITEMS_FILE")
	addresscountry=$(jq ".[$j].address.country // \"\"" "$ITEMS_FILE")
	addressareaofinteresta=$(jq ".[$j].address.areaOfInterest[0] // \"\"" "$ITEMS_FILE")
	addressareaofinterestb=$(jq ".[$j].address.areaOfInterest[1] // \"\"" "$ITEMS_FILE")

	echo "Writing data to $CSV_FILE"
	echo "$datetime","$name","$serialnumber","$producttype","$productindentifier","$vendoridentifier","$antennapower","$systemversion","$batterystatus","$locationpositiontype","$locationlatitude","$locationlongitude","$locationtimestamp","$locationverticalaccuracy","$locationhorizontalaccuracy","$locationfloorlevel","$locationaltitude","$locationisinaccurate","$locationisold","$locationfinished","$addresslabel","$addressstreetaddress","$addresscountrycode","$addressstatecode","$addressadministrativearea","$addressstreetname","$addresslocality","$addresscountry","$addressareaofinteresta","$addressareaofinterestb" >> "$CSV_FILE"

	done
	echo -e "Checking again in 1 minute...\n"
	sleep 60

done