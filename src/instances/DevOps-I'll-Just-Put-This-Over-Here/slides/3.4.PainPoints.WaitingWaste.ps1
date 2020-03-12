
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
        __          __   _ _   _              __          __       _
        \ \        / /  (_) | (_)             \ \        / /      | |        _
         \ \  /\  / /_ _ _| |_ _ _ __   __ _   \ \  /\  / /_ _ ___| |_ ___  (_)
          \ \/  \/ / _`` | | __| | '_ \ / _`` |   \ \/  \/ / _`` / __| __/ _ \
           \  /\  / (_| | | |_| | | | | (_| |    \  /\  / (_| \__ \ ||  __/  _
            \/  \/ \__,_|_|\__|_|_| |_|\__, |     \/  \/ \__,_|___/\__\___| (_)
                                        __/ |
                                       |___/";

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$Summary = (
    'Uneven processes and teams can cause a lot of waiting around. Having team members that are too specialized can cause them to be excluded from work because "that''s not what they are good at." Also waiting around on a development environment can cripple a teams ability to work as a cohesive group. Do everything you can to shine a lot on these constraints!'
);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Where does it hurt?' | Get-IndentedText -IndentBy 8) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6) `
    -Complete;
