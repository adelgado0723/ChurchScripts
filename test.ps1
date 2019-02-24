# Make Global variables to control
# - Number of videos processed
# - Names of processed videos

$USBDrives = Get-WmiObject Win32_Volume -Filter "DriveType='2'"
if ($USBDrives  -is [system.array])
{
    $USBDrive = $USBDrives[0]|select -expand driveletter
}else
{
    $USBDrive = $USBDrives|select -expand driveletter
}


if($USBDrive) 
{
	if(Test-Path -Path "$USBDrive\DCIM\")
	{
		# Proceed to find most recently changed folder
		$VideoDir = "$USBDrive\DCIM\"; 
		
		$LastModedFolder = Get-ChildItem -Path $VideoDir | Where-Object {$_.PSIsContainer} | Sort-Object LastWriteTime -Descending | Select-Object -First 1 ;
		 # echo "$LastModedFolder";
		if($LastModedFolder)
		{
			$VideoDir = "$VideoDir\$LastModedFolder";
			# Find most recently added video
			
			$LastModdedFile = gci | Where-Object {$_.Extension -eq ".MP4"} | $VideoDir | sort LastWriteTime ; # | select -last 1;
			# Iterate through list and classify as 10am service or 1130am service 
		
			$LMPath = "$VideoDir\$LastModdedFile";
			echo "Found most recently added file ==> $LMPath";
			
			#mkdir $StoragePath\testing!!!;
			
			$StoragePath = "C:\Users\Sanctuary\Desktop\Sermons Web";
			$Today = Get-Date -UFormat "%m-%d-%y";
			# Prepare directories for storing processed videos
			if(Test-Path -Path "$StoragePath\$Today")
			{
				# Check if 1000am has already been processed
				# if so, skip
				# Do the same for 1130am
			
			}
			else
			{
				# Create Path
				New-Item -ItemType Directory -Path "$StoragePath\$Today" -Force;
			}
			
			# Send file(s) to HandBrake
			
			# Delete file(s) on memory card
		}
		else
		{
			echo "No Directories found in $VideoDir";
		}
	}
	else
	{
		echo "$USBDrive\DCIM\ -- NOT FOUND!";
	}

# echo $USBDrive ;
}
else 
{
	echo "No USB Drives found.";
}

