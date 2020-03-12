
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
         _____                      _                     __          __       _
        |_   _|                    | |                    \ \        / /      | |        _
          | |  _ ____   _____ _ __ | |_ ___  _ __ _   _    \ \  /\  / /_ _ ___| |_ ___  (_)
          | | | '_ \ \ / / _ \ '_ \| __/ _ \| '__| | | |    \ \/  \/ / _`` / __| __/ _ \
         _| |_| | | \ V /  __/ | | | || (_) | |  | |_| |     \  /\  / (_| \__ \ ||  __/  _
        |_____|_| |_|\_/ \___|_| |_|\__\___/|_|   \__, |      \/  \/ \__,_|___/\__\___| (_)
                                                   __/ |
                                                  |___/";

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$Summary = (
    'Have you ever found yourself finished with a project long before the next person or team is available to pick it up? "Product," or in this case, work items continue to pile up, with no one available to complete the work and ship it to production. This can lead to longer testing time, and "Big Bang" releases. The objective here is single-piece flow. This will drastically reduce the time spent waiting around for others needed to complete your task!'
);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Where does it hurt?' | Get-IndentedText -IndentBy 8) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6) `
    -Complete;
