# sources :
# https://stackoverflow.com/questions/10781697/convert-unix-time-with-powershell
# http://codeclimber.net.nz/archive/2007/07/10/convert-a-unix-timestamp-to-a-net-datetime/

# added format (belgian-french)
Function Convert-FromUnixDate ($UnixDate) {
   [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($UnixDate)).ToString('dd-MM-yyyy hh:mm:ss')
}

# inspired by .Net
static DateTime ConvertFromUnixTimestamp(double timestamp)
{
    DateTime origin = new DateTime(1970, 1, 1, 0, 0, 0, 0);
    return origin.AddSeconds(timestamp);
}
static double ConvertToUnixTimestamp(DateTime date)
{
    DateTime origin = new DateTime(1970, 1, 1, 0, 0, 0, 0);
    TimeSpan diff = date - origin;
    return Math.Floor(diff.TotalSeconds);
}
