#!/bin/bash

# Copyright (c) 2020 Liam Whittle
# This software is covered by the MIT licence. Refer to LICENCE.txt.
# Use this program at your own risk. You must refer to README.md for how to use it.

# Path where the initial list of folders to copy is. Essentially, this path points to the
# latest backup. I'm not sure what to do if you want an older version of your backup... Honestly, you'll probably
# only want the stuff in "Users" - in that case find the corresponding PRIVATE_DIRECTORY_DATA folder and put that here.
# Use the instructions in the first link in README.md - this explains a lot of how the below code works as well :)
COPY_PATH=/home/$USER/TimeMachineMount/Backups.backupdb/Macintosh/Latest/Macintosh HD
# This is the main path where all the actual backup data resides.
DATA_PATH=/home/$USER/Desktop/TimeMachineMount/PRIVATE_DIRECTORY_DATA
# This is where we will be saving our extracted data. Edit to your liking.
PASTE_PATH=/home/$USER/Desktop/TimeMachineConverted

# The following is a recursive function. It traverses Apple's weird file system for backups and constructs an actual
# file system with all the files copied in. Please note that I learned bash for the first time while doing
# this... there's likely a way of doing it in one line with "find", but I couldn't work it out. If you do, please send
# a pull request!
# parameters: $1 = directory to search, $2 = directory to create within
create_dirs()
{
  local SEARCH_DIR=$1
  local WRITE_DIR=$2

  # enter the search directory for search
  cd "${SEARCH_DIR}"

  for file in *
	  do
      # Re enter directory (recursive calls will possibly have changed it)
      cd "${SEARCH_DIR}"

      # extract the file pointer using a regular expression
      local PTR=$(ls -l "${file}">&1)
		  local NUM=$(echo "$PTR" | grep -oh "[0-9]*" | head -1)

      # CONTAINER_DIR is the absolute path to a potential file container
      local CONTAINER_DIR=${DATA_PATH}/dir_${NUM}

      # if the pointer points to a directory, create and recurse
      if [[ -d "${CONTAINER_DIR}" ]]; then
        # make the directory in the skeleton path
        mkdir "$WRITE_DIR/$file"

        # recursively create required directories. echo below for debug
        echo "create_dirs $CONTAINER_DIR $WRITE_DIR/$file"
        create_dirs "$CONTAINER_DIR" "$WRITE_DIR/$file"

      # if the object we have examined is actually a directory, copy the directory name over and recurse
      elif [[ -d "${SEARCH_DIR}/${file}" ]]; then
        # make the directory in the skeleton path
        mkdir "$WRITE_DIR/$file"

        # recursively create required directories from the CURRENT directory - NOT the container directory
        echo "create_dirs $SEARCH_DIR_DIR/$file $WRITE_DIR/$file"

        create_dirs "$SEARCH_DIR/$file" "$WRITE_DIR/$file"

      # if it is simply a file, we can copy it over
      elif [[ -f "${SEARCH_DIR}/${file}" ]]; then
          cp "${SEARCH_DIR}/${file}" "${WRITE_DIR}" -v
      fi
      cd "${SEARCH_DIR}"
    done
}

# recursively search through directories starting with DATA_PATH, the path to search for directory pointers,
# and PASTE_PATH, the path to past in a new directory structure.
create_dirs $COPY_PATH $PASTE_PATH
