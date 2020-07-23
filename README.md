# TimeMachineLinuxExtractor

This repo contains some instructions below and code for converting an old Apple Time Machine backup to a readable, vanilla file system on Ubuntu.

As the included MIT licence states, I make *absolutely no guarantee* that any of the advice or code in this repository is safe for use. This happened to work for 
my requirements, however there is always a risk of corrupting data. Even if it does appear to work, it's really hard to tell if it's copied over all the files 
completely, so bear that in mind.

The motivation for this repo is having an old Time Machine backup from 2013-14, but no Mac to access the files on, so therefore wanting to convert to a normal file 
system. 

<u>Steps</u>:

1. Mount the drive to your file system. It may have already mounted, however you will want to mount it with write permissions if you are going to follow the below 
   steps. 
   General instructions for this are here: http://hints.macworld.com/article.php?story=20080623213342356, however you'll want to follow additional instructions   
   from here to make sure you get read/write permissions for all files: https://askubuntu.com/questions/332315/how-to-read-and-write-hfs-journaled-external-hdd-in-ubuntu-without-access-to-os. Let's assume you mount it to ~/Desktop/TimeMachineMount/.

2. Before doing anything else, probably best to make a copy of the entire Time Machine backup to some other working directory:
   Run the following command in ~/Desktop:
   sudo cp -r TimeMachineMount/ ~/Desktop/TimeMachineCopy

   Since we will be converting the TimeMachineCopy to another format in a new folder, your computer will need at least 2x the extra storage capacity of the
   original drive. Therefore if you don't have this extra space on hand, you can either mount another external drive to serve this purpose, or risk doing the 
   following steps all on the original drive. Be careful!

3. Now simply download and run the TimeMachineLinuxExtractor.sh file (located in this repository):
   
   a) Paste TimeMachineLinuxExtractor.sh into Desktop
   b) Set the execute permission for the file by typing:
   chmod 770 TimeMachineLinuxExtractor.sh
   
   c) Run the extractor by typing:
   ./TimeMachineLinuxExtractor TimeMachineBackup
   
   If all goes well, you should have a fully accessible copy of your full latest backup in ~/Desktop/TimeMachineExtracted
   
   Voila!
   
