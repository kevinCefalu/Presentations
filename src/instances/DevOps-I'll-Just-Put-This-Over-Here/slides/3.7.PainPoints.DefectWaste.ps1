
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
         _____        __          _     __          __       _
        |  __ \      / _|        | |    \ \        / /      | |        _
        | |  | | ___| |_ ___  ___| |_    \ \  /\  / /_ _ ___| |_ ___  (_)
        | |  | |/ _ \  _/ _ \/ __| __|    \ \/  \/ / _`` / __| __/ _ \
        | |__| |  __/ ||  __/ (__| |_      \  /\  / (_| \__ \ ||  __/  _
        |_____/ \___|_| \___|\___|\__|      \/  \/ \__,_|___/\__\___| (_)";

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$Summary = (
    'In cultures with highly segregated teams (especially those with dedicated QA teams) quality is not often built into the product. The attitude of "QA will find anything I missed" can lead to major upset by management, or much worse the customer! Make sure to build quality into your product by way of your SDLC. This is also known as "Shifting Left." By shifting left, you put the focus on software excellence as early in the products'' development as possible.'
);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Where does it hurt?' | Get-IndentedText -IndentBy 8) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6) `
    -Complete;
