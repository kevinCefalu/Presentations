
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
          ____                        _____                             _
         / __ \                      |  __ \                           (_)
        | |  | |_   _____ _ __ ______| |__) | __ ___   ___ ___  ___ ___ _ _ __   __ _
        | |  | \ \ / / _ \ '__|______|  ___/ '__/ _ \ / __/ _ \/ __/ __| | '_ \ / _`` |
        | |__| |\ V /  __/ |         | |   | | | (_) | (_|  __/\__ \__ \ | | | | (_| |
         \____/  \_/ \___|_|   _     |_|   |_|  \___/ \___\___||___/___/_|_| |_|\__, |
          \ \        / /      | |        _                                       __/ |
           \ \  /\  / /_ _ ___| |_ ___  (_)                                     |___/
            \ \/  \/ / _`` / __| __/ _ \
             \  /\  / (_| \__ \ ||  __/  _
              \/  \/ \__,_|___/\__\___| (_)";

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$Summary = (
    'As developers we tend to fall victim to "gold-plating." Make sure you have a clear, well-defined list of requirements to avoid over-engineering. Companies will often inject unneeded work, simply to keep their staff at 100% utilization. This even includes over-testing a product; sometimes it really is "good enough!"'
);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Where does it hurt?' | Get-IndentedText -IndentBy 8) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6) `
    -Complete;
