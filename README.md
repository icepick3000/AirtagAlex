# AirtagAlex
Get all metadata from the Airtags (lat, lon, geocoding information, precision range, battery status).
This script is a very basic script to write the data to a CSV for processing in Excel or Numbers. I am sure many rewrites will be done by other folks but anyone with some programming experience will have a good starting point with this script. 


[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg)](https://www.youtube.com/watch?v=YOUTUBE_VIDEO_ID_HERE)



Steps to get this script to work (for Noobs);

Create a folder on your desktop called <i>Airtags</i> (case sensitive)<BR>
Install brew (<A HREF="wwww.brew.sh" TARGET=new>www.brew.sh</A>)<BR>
  Install the jq utility (<i>brew install jq</I>)<BR>
  Change the directory to the newly created Airtags folder by typing <i>cd ~/Desktop/Airtags</I><BR>
  Clone this repo by typing <i>git clone https://github.com/icepick3000/AirtagAlex.git</I><BR>
  Go into the repo directory by typing <i>cd ~/Desktop/Airtags/AirtagAlex</I><BR>
  Make the shell file executable by typing <I>chmod 700 AirtagAlex.sh</I><BR>
  
  You can start the script by typing;
  
  <B><I>./AirtagAlex.sh</I></B>
  
  The output will look something like this;<BR>
  <I>Create a copy of the Items.data file to prevent changes while the script is running<BR>
Check if Airtags.csv exists<BR>
Check how many Airtags to process<BR>
Number of Airtags to process:       4<BR>
Processing airtag number 0<BR>
Write the data to the Airtags.csv file<BR>
Processing airtag number 1<BR>
Write the data to the Airtags.csv file<BR>
Processing airtag number 2<BR>
Write the data to the Airtags.csv file<BR>
Processing airtag number 3<BR>
Write the data to the Airtags.csv file<BR>
Sleep for 1 minute (60 seconds)</I><BR>
  
  The results in CSV format can be found on your desktop in the Airtags folder!
    
 To see all my Airtag adventures check out my channel at https://www.youtube.com/c/AirtagAlex
    If this script was of use to you a referal in your video or project would be highly appreiciated. 
    
