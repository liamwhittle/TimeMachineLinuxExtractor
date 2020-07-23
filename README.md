# TimeMachineLinuxExtractor

This repo contains some instructions below and code for converting an old Apple Time Machine backup to a readable, vanilla file system on Ubuntu.

As the included MIT licence states, I make *absolutely no guarantee* that any of the advice or code in this repository is safe for use. This happened to work for 
my requirements, however there is always a risk of corrupting data. Even if it does appear to work, it's really hard to tell if it's copied over all the files 
completely, so bear that in mind.

The motivation for this repo is having an old Time Machine backup from 2013-14, but no Mac to access the files on, so therefore wanting to convert to a normal file 
system.

<u>Steps</u>:

1. Mount the drive to your file system. It may have already mounted, however you will want to mount it with write permissions 
   if you are going to follow the below steps. General instructions for this are here: http://hints.macworld.com/article.php?story=20080623213342356, however 
   you'll want to follow additional instructions from here to make sure you get read/write permissions for all files: https://askubuntu.com/questions/332315/how-to-read-and-write-hfs-journaled-external-hdd-in-ubuntu-without-access-to-os. Let's assume you mount it to ~/Desktop/TimeMachineMount/. IF you choose another 
   location, change COPY_PATH in the code!

2. Before doing anything else, it's probably best to make a copy of the entire Time Machine backup to some other directory:
   Run the following command in ~/Desktop:
   sudo cp -r TimeMachineMount/ ~/Desktop/TimeMachineCopy

3. This next step will temporarily break your original backup (in the sense that a Mac probably wouldn't recognize it) but is          
   easy to reverse and made this process easier in my case. If you can figure out a way to make the code work without this 
   step, please create a pull request!
   
   All you need to do is rename the directory cd ~/Desktop/TimeMachineMount/.HFS+ Private Directory Data
   In my case, the filename had a \r character, which totally messed with my code (and terminal). I renamed it to PRIVATE_DIRECTORY_DATA.
   If you aren't going to do this, then you'll need to change the DATA_PATH variable in tmlx.sh. 
   Probably change it back afterwards. This is why I wanted to mount the drive with write permissions.

4. Download and READ THE CODE in tmlx.sh (make sure relevant paths are correct), then run.
   
   If all goes well, you should have a fully accessible copy of your full latest backup in ~/Desktop/TimeMachineConverted,
   or wherever you decided to send the files.
   
Good luck!
