Set-StrictMode -Version 2
$ErrorActionPreference = "Stop"

Import-Module Visio

$app= New-VisioApplication
$doc = New-VisioDocument
$stencil_net = Open-VisioDocument "Basic Network Diagram.vst"
$stencil_comp = Open-VisioDocument "Computers and Monitors.vss"


$pc_master = Get-VisioMaster "PC" $stencil_comp 
$shapes = New-VisioShape -Masters $pc_master -Points 2.2,6.8
Set-VisioText "Some Text..."
Set-VisioCustomProperty -Name "prop1" -Value "val1"
Set-VisioCustomProperty -Name "prop2" -Value "val2"


$shapedata_col = Get-VisioCustomProperty -Shapes $shapes 
foreach ($shapedata in $shapedata_col)
{
    Write-Host "--------------------------------------"
    Write-Host Name $shapedata.Name
    Write-Host Type $shapedata.Type
    Write-Host Value $shapedata.Value
    Write-Host Prompt $shapedata.Prompt
    Write-Host Ask $shapedata.Ask
    Write-Host Calendar $shapedata.Calendar
    Write-Host Format $shapedata.Format
    Write-Host Invisible $shapedata.Invisible
    Write-Host Label $shapedata.Label
    Write-Host LangId $shapedata.LangId
    Write-Host ShapeID $shapedata.ShapeID
    Write-Host SortKey $shapedata.SortKey
}