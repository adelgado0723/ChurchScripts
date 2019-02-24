# HandBrake Command

$MP4s = Get-ChildItem  "F:\DCIM\329_0224" | Where-Object {$_.Extension -eq ".MP4"} | sort LastWriteTime -descending; # | select -last 1;
foreach ($mp4 in $MP4s)
{
	$lwt = $mp4.LastWriteTime.ToString("hh");
	$out = "";
	if($lwt -eq "11" -or $lwt -eq "12")
	{
		$out = "This is an 10:00am service video";
	}
	elseif($lwt -eq "01" -or $lwt -eq "02")
	{
		$out = "This is an 11:30am service video";
	}
	else
	{
		$out = "This is an unconventional service time.";
	}
	echo $out;
	echo "FILE NAME = $mp4 ; Last Write Time = $lwt;";

}
