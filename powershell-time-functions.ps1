# source : https://stackoverflow.com/questions/10781697/convert-unix-time-with-powershell

Function Convert-FromUnixDate ($UnixDate) {
   [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($UnixDate))
}
