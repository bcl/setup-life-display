= Initial setup of SD card for Life Display

Download Pi OS lite version from
https://www.raspberrypi.com/software/operating-systems/

unxz the image and use `dd` to write it to a SD card.

Mount the SD card / and /boot on a directory under /mnt/, eg.

sudo mkdir -p /mnt/d1/boot /mnt/d1/root
sudo mount /dev/mmcblk0p1 /mnt/d1/boot
sudo mount /dev/mmcblk0p2 /mnt/d1/root

Run the ./setup.sh script, passing /mnt/d1/

sudo ./setup.sh /mnt/d1/

Edit /mnt/d1/boot/wpa_supplicant.conf and change the SSID and password to your AP.

Optionally change the password of the life user by replacing the default password in
/mnt/d1/boot/userconf with the output from:
openssl passwd -6

Unmount /mnt/d1/boot and /mnt/d1/root and insert the SD card into the Pi and boot it.

It is best to do this with a display and keyboard so you can see what IP address is assigned,
or deal with any unexpected errors.

Now you can reboot, and it should show the IP address at the login prompt, depending on the
timing of bringing up the network.

Edit the hosts file to set the correct IP address.
Run the setup.yml playbook to setup the life display and change the boot display settings.

ansible-playbook -v -k ./setup.yml

the SSH password will be the password you created for the 'life' user. Or the default of
asdasdasd

= Build sdl2-life

It is easiest to just build the sdl2-life program on the Pi. The git repo has been checked
out into /opt/sdl2-life/ and it should simply be a matter of running:

    cd /opt/sdl2-life && go build

to build it.

= Final Steps

At this point the system should be ready. You can run /home/life/run-life-server to test, and
then reboot to make sure it starts on its own.

If everything looks ok you can turn off the boot logo and text by editing /boot/cmdline.txt
and adding:

    logo.nologo console=null quiet

to the end of the kernel boot cmdline. This does make it much harder to debug problems, but
worst case you can mount the SD card on another system and remove those arguments to turn
them back on.

