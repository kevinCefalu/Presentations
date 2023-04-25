
. "$PSScriptRoot\..\utilities\Get-IndentedText.ps1";
. "$PSScriptRoot\..\utilities\Get-WrappedText.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideSection.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideTable.ps1";

$LineCounts = [PSCustomObject] @{
    Available = [Console]::WindowHeight - 2;
    Used = 0;
};

$SlideTitle = "
         __  __       _   _               __          __       _
        |  \/  |     | | (_)              \ \        / /      | |        _
        | \  / | ___ | |_ _  ___  _ __     \ \  /\  / /_ _ ___| |_ ___  (_)
        | |\/| |/ _ \| __| |/ _ \| '_ \     \ \/  \/ / _`` / __| __/ _ \
        | |  | | (_) | |_| | (_) | | | |     \  /\  / (_| \__ \ ||  __/  _
        |_|  |_|\___/ \__|_|\___/|_| |_|      \/  \/ \__,_|___/\__\___| (_)";

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$Summary = (
    'Often times you can find situations where there''s a lot of unnecessary movement of people and technology stacks. Manual data entry requirements into mutliple systems, and rubber-stamping of approvals can cripple an organization, and cause a lot of unforseen issues. Do your best to automate these instances away!'
);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Where does it hurt?' | Get-IndentedText -IndentBy 8) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6) `
    -Complete;
