function Get-DotNetVersion
{
    Clear-Host
    Write-Host 'Installed .NET Framework Components' -ForegroundColor Yellow
    Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse |
    Get-ItemProperty -Name Version,Release -ErrorAction 0 |
    Where-Object { $_.PSChildName -match '^(?!S)\p{L}'} |
    Select-Object -Property @{N='.NET Component';E={$_.PSChildName}}, @{N='Version';E={$_.Version}} |
    Sort-Object -Property Version -Descending |
    Format-Table -AutoSize
}

function Test-Domain
{
[CmdletBinding()]
    param
    ([parameter(Position=0,
       Mandatory=$true,
       ValueFromPipeline=$true,
       ValueFromPipelineByPropertyName=$true)]
       [string]$ComputerName='.'
    )
BEGIN{}
PROCESS
{
    Write-Host 'Domain or workgroup Membership' -ForegroundColor Green
    Get-WmiObject -Class Win32_ComputerSystem -Computername $ComputerName |
    Select-Object -Property Name, Domain | Format-Table -AutoSize
}
END{}
    
}
Get-DotNetVersion
Test-Domain -ComputerName 'localhost'