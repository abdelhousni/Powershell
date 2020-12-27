# Visio automation via PowerShell - stackoverflow.com
# source : https://stackoverflow.com/questions/14730083/visio-automation-via-powershell?rq=1


$application = New-Object -ComObject Visio.Application
$application.visible = $true
$documents = $application.Documents
$document = $documents.Add("Basic Network Diagram.vst")
$pages = $application.ActiveDocument.Pages
$page = $pages.Item(1)


$ComputerStencil = $application.Documents.Add("Computers and Monitors.vss")



$pc = $ComputerStencil.Masters.Item("PC")
$shape1 = $page.Drop($pc, 2.2, 6.8)
$shape1.Text = "Some text...."