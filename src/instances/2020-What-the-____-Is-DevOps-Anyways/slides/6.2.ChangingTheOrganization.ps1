
. "$PSScriptRoot\..\utilities\Get-IndentedText.ps1";
. "$PSScriptRoot\..\utilities\Get-WrappedText.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideSection.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideTable.ps1";

$LineCounts = [PSCustomObject] @{
    Available = [Console]::WindowHeight - 3;
    Used = 0;
};

$SlideTitle = "
          _____ _                       _               _   _
         / ____| |                     (_)             | | | |
        | |    | |__   __ _ _ __   __ _ _ _ __   __ _  | |_| |__   ___
        | |    | '_ \ / _`` | '_ \ / _`` | | '_ \ / _`` | | __| '_ \ / _ \
        | |____| | | | (_| | | | | (_| | | | | | (_| | | |_| | | |  __/
         \_____|_| |_|\__,_|_| |_|\__, |_|_| |_|\__, |  \__|_| |_|\___|
                                   __/ |         __/ |
          ____                    |___/         |___/_
         / __ \                      (_)        | | (_)              _
        | |  | |_ __ __ _  __ _ _ __  _ ______ _| |_ _  ___  _ __   (_)
        | |  | | '__/ _`` |/ _`` | '_ \| |_  / _`` | __| |/ _ \| '_ \
        | |__| | | | (_| | (_| | | | | |/ / (_| | |_| | (_) | | | |  _
         \____/|_|  \__, |\__,_|_| |_|_/___\__,_|\__|_|\___/|_| |_| (_)
                     __/ |
                    |___/";

$SlideSections = @(
    [PSCustomObject] @{
        Detail = "- Step back and take in the whole picture";
    }
    [PSCustomObject] @{
        Detail = "- Perform value stream mapping to focus efforts on the customers' needs";
    }
    [PSCustomObject] @{
        Detail = "- Put a spotlight on your constraints";
    }
    [PSCustomObject] @{
        Detail = "- Throw out old and inconsistent development environments";
    }
    [PSCustomObject] @{
        Detail = "- Automate the path to production and ditch unnecessary manual intervention";
    }
    [PSCustomObject] @{
        Detail = "- QA are not solely responsible for Quality; shift left!";
    }
);

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

for ($i = 0; $i -lt $SlideSections.Count; $i++)
{
    $LineCounts.Used = ($LineCounts | Write-SlideSection `
        -Text ($SlideSections[$i].Detail | Get-WrappedText -IncreaseIndentBy 10) `
        -Complete:($i -eq ($SlideSections.Count - 1))) + 1;
}
