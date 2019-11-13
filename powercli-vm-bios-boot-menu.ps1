# source : https://code.vmware.com/forums/2530/vsphere-powercli#545814

$vmName = 'TestVM'
$vm = Get-VM -Name $vmName
$spec = New-Object VMware.Vim.VirtualMachineConfigSpec
$spec.BootOptions = New-Object VMware.Vim.VirtualMachineBootOptions
$spec.BootOptions.BootDelay = 10000
$vm.ExtensionData.ReconfigVM($spec)
