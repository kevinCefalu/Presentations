
. "$PSScriptRoot\..\utilities\Get-IndentedText.ps1";
. "$PSScriptRoot\..\utilities\Get-WrappedText.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideSection.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideTable.ps1";

$LineCounts = [PSCustomObject] @{
    Available = [Console]::WindowHeight - 4;
    Used = 0;
};

$SlideTitle = "
         _______                  _ _   _             _
        |__   __|                (_) | (_)           (_)
           | |_ __ __ _ _ __  ___ _| |_ _  ___  _ __  _ _ __   __ _
           | | '__/ _`` | '_ \/ __| | __| |/ _ \| '_ \| | '_ \ / _`` |
           | | | | (_| | | | \__ \ | |_| | (_) | | | | | | | | (_| |
           |_|_|  \__,_|_|_|_|___/_|\__|_|\___/|_| |_|_|_| |_|\__, |
           | |        |  __ \            / __ \             _  __/ |
           | |_ ___   | |  | | _____   _| |  | |_ __  ___  (_)|___/
           | __/ _ \  | |  | |/ _ \ \ / / |  | | '_ \/ __|
           | || (_) | | |__| |  __/\ V /| |__| | |_) \__ \  _
            \__\___/  |_____/ \___| \_/  \____/| .__/|___/ (_)
                                               | |
                                               |_|
";

$SlideSections = @(
    [PSCustomObject] @{
        Detail = "- Trust the team and your coworkers";
    }
    [PSCustomObject] @{
        Detail = '- Anyone should be able to "pull the cord" without fear of retrobution';
    }
    [PSCustomObject] @{
        Detail = "- Staff should be free to form their own S.W.A.T. teams during times of crisis";
    }
    [PSCustomObject] @{
        Detail = "- Expect a culture of cooperation and co-mingling, even (especially) when not in crisis";
    }
);

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ('Empowerment' | Get-IndentedText -IncreaseIndentBy 8);

for ($i = 0; $i -lt $SlideSections.Count; $i++)
{
    $LineCounts.Used = ($LineCounts | Write-SlideSection `
        -Text ($SlideSections[$i].Detail | Get-WrappedText -IncreaseIndentBy 10) `
        -Complete:($i -eq ($SlideSections.Count - 1))) + 1;
}
