
function Invoke-StartStopProcess
{
    param (
        [Parameter(Mandatory)]
        [string] $ProcessName,

        [Parameter(Mandatory)]
        [string] $ExePath
    );

    Start-Process -FilePath $ExePath -PassThru | Out-Null;

    while ($null -eq (Get-Process -Name $ProcessName -ErrorAction:SilentlyContinue))
    {
        Start-Sleep -Seconds 1;
    }

    Start-Sleep -Seconds 30;

    Stop-Process -Name $ProcessName -Force -PassThru -ErrorAction:Continue | Out-Null;
}
