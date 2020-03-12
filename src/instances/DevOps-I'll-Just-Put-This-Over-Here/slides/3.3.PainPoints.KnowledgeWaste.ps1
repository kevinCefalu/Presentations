
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
         _  __                    _          _             __          __       _
        | |/ /                   | |        | |            \ \        / /      | |        _
        | ' / _ __   _____      _| | ___  __| | __ _  ___   \ \  /\  / /_ _ ___| |_ ___  (_)
        |  < | '_ \ / _ \ \ /\ / / |/ _ \/ _`` |/ _`` |/ _ \   \ \/  \/ / _`` / __| __/ _ \
        | . \| | | | (_) \ V  V /| |  __/ (_| | (_| |  __/    \  /\  / (_| \__ \ ||  __/  _
        |_|\_\_| |_|\___/ \_/\_/ |_|\___|\__,_|\__, |\___|     \/  \/ \__,_|___/\__\___| (_)
                                                __/ |
                                               |___/";

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$Summary = (
    'The flow and absorption of knowledge can sometimmes be blocked by physical, mental and even cultural barriers. Do your best to eliminate these walls and help your coworkers! Learn and teach something new every day.'
);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Where does it hurt?' | Get-IndentedText -IndentBy 8) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6) `
    -Complete;
