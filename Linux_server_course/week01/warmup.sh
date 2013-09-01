#!/usr/bin/bash
# Might contain typos. Tested on live-USB session of Xubuntu 12.04 64bit.

printf "Generating the installation report...\n"
cat > install.txt <<EOF
You can download the image from here: http://xubuntu.org/getxubuntu/
Unless you are working on an old machine, 64bit might be a better choice.

After download is finished, it's time to get down to business.
Before plugging the USB-stick into your computer, run:

$ lsblk

Make note of the devices listed there.
Then plug the stick into the machine, and run the command again.
There should have appeared a new device, the USB-stick.
Traverse to the directory containing the downloaded iso-file.
Check the USB-stick is not mounted before running the command.
Also, the /dev/sdX is the name of the device, for example /dev/sdc.
As a final note, double and triple check that the device is correct!

# dd if=the_xubuntu.iso of=/dev/sdX bs=1M

Before taking the newly created live-USB to the field, it'll
serve you well to test it at home first, too!

In case of any issues, archwiki, man pages and IRC channels,
in this order, will provide you with much info and help.
EOF
printf "The install.txt has been generated!\n"
sleep 1
printf "Generating exam.sh...\n"
cat > exam.sh <<"EOF"
#!/usr/bin/bash

# We need root privileges.
test "$UID" -ne 0 && printf "Run root!\n" && exit 0

cat <<"EOS"
GNU+Linux exam, by Tero Karvinen.
koe: http://terokarvinen.com/2012/linux-koe-tyoasemat-ja-tietoverkot-25
EOS

cat <<"EOS"
Prevent screen blanking:
xset -dpms
xset s noblank
xset s noexpose
EOS
sleep 1
xset -dpms
xset s noblank
xset s noexpose

cat <<"EOS"
Update the package lists and install some software
for text processing and also the LAMP stack:
apt-get update && apt-get install firefox libreoffice
vim openssh-server apache2 mysql-server php5 php5-musql phpmyadmin
Do go get yourself a cup of tea while waiting.
Notice: Some of these will prompt you for passwords and such!
EOS
sleep 1
apt-get update && apt-get install firefox libreoffice \
vim openssh-server apache2 mysql-server php5 php5-mysql phpmyadmin

printf "Generating mystatus.sh..\n"
cat > mystatus.sh <<"EOS"
#!/usr/bin/bash
# Handle optional commandline arguments, you can specifically
# tell the script to use certain device and network interface.
# To only change the net interface, do: $0 "" <interface>
a1="$1"
a2="$2"
devi="${a1:-sda1}"
net="${a2:-eth0}"

printf "Vapaa levytila: %s\n" $(df -h|awk '/'$devi' / {print $4}')
printf "IP osoitteesi: %s\n" $(ip -o -4 a|\
    awk '/'$net'/ {sub(/\/.*$/,""); print $4}')
EOS

chmod 755 mystatus.sh
cp -p mystatus.sh /usr/local/bin/mystatus
printf "Mystatus generated and installed in /usr/local/bin..\n"
sleep 1

printf "Dealing with the evils of PHP...\n"
# We pollute /etc/skel so that we don't have to create these
# for each user separately.
mkdir /etc/skel/public_html
cat > /etc/skel/public_html/index.php <<"EOS"
<?php print("Vomit the World!\n"); ?>
EOS

printf "Creating the users...\n"
declare -a userlist=('vahakaahka' 'winha' 'andersson' 'laila')
for user in "${userlist[@]}"; do
    printf "${user}"
    useradd -m -g users -s /bin/bash "${user}"
    passwd "${user}"
done

printf "Dealing with apache..\n"
a2enmod userdir
sed s/php_admin/#php_admin/ -i /etc/apache2/mods-available/php5.conf
service apache2 restart

printf "All done!\n"
EOF
chmod 755 exam.sh
printf "The exam.sh has been generated!\n\n"

cat <<EOF
We generated two text files:
install.txt, which contains a report on how to get Xubuntu and how
to mutilate a USB-stick with the image using dd, Destroyer of Disks.

exam.sh, which solves the provided exam. Note that you'll need
root privileges to run it, since it installs some software and
creates 4 new users.

After running exam.sh:
Ssh was tested by connecting to the same machine we were using
at the moment with a command 'ssh localhost'.
Apache was tested by opening a web browser and typing 'localhost'
in the address bar. It insisted that "It works!"

PHP is evil. So that you know. You should also probably not use it.
These people wanted it, and they got it, too, unfortunately.

All the passwords were, on this occasion, given by hand. Naturally,
with more users, generating them would've been a better idea.
User passwords would have been given to them face to face,
accompanied by a lecture on the evils of PHP and of the degradation
of web in general.

You might also like to know, that it is probably a command called
'lspci' you want in most cases be using instead of 'lshw', which
tells a great deal of information to you about the hardware of
your computer. lshw might come in handy should you want to play
around with more obscure systems on which hardware compability
can an issue.

As a sidenote, we run into some issues. PHP didn't work at first
and then after doing something mad(ie. repeating the very same thing
I had done a moment ago) it started to function.
Also, the first "final" draft of this got corrupted and I had to rewrite
about one third of this again. Hence double possibility of typos.
You have been warned.
EOF
