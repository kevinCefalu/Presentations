
. "$PSScriptRoot\..\utilities\Get-IndentedText.ps1";
. "$PSScriptRoot\..\utilities\Get-WrappedText.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideSection.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideTable.ps1";

$LineCounts = [PSCustomObject] @{
    Available = [Console]::WindowHeight - 5;
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

$Summary = 'So what do I need to do to get from here to there?';

$SlideSections = @(
    [PSCustomObject] @{
        Detail = "- Reestablish purpose to shared company goals";
    }
    [PSCustomObject] @{
        Detail = "- Empathize with your customer";
    }
    [PSCustomObject] @{
        Detail = "- Avoid (just) going through the Agile motions";
    }
    [PSCustomObject] @{
        Detail = "- Value quality over due dates";
    }
);

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 8);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ('Changing the culture' | Get-IndentedText -IncreaseIndentBy 8);

for ($i = 0; $i -lt $SlideSections.Count; $i++)
{
    $LineCounts.Used = ($LineCounts | Write-SlideSection `
        -Text ($SlideSections[$i].Detail | Get-WrappedText -IncreaseIndentBy 10) `
        -Complete:($i -eq ($SlideSections.Count - 1))) + 1;
}
