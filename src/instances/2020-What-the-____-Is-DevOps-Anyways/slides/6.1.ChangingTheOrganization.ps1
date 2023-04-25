
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
                    |___/
";

$LineCounts.Used = $LineCounts | Write-SlideSection -Text $SlideTitle;

$Summary = (
    "`"I can't design anything tryly useful unless I understand the people for whom I'm designing`" - Jeff Sussna"
);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6) `
    -Complete;
