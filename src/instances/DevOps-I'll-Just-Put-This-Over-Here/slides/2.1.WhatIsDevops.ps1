
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
          _____                    _           _       _         _   _     _
         / ____|                  | |         | |     (_)       | | | |   (_)
        | (___   ___     __      _| |__   __ _| |_     _ ___    | |_| |__  _ ___
         \___ \ / _ \    \ \ /\ / / '_ \ / _`` | __|   | / __|   | __| '_ \| / __|
         ____) | (_) |    \ V  V /| | | | (_| | |_    | \__ \   | |_| | | | \__ \
        |_____/_\___/      \_/\_/ |_|_|_|\__,_|\__|   |_|___/    \__|_| |_|_|___/
              |  __ \            / __ \
              | |  | | _____   _| |  | |_ __  ___     _   _  ___  _   _
              | |  | |/ _ \ \ / / |  | | '_ \/ __|   | | | |/ _ \| | | |
              | |__| |  __/\ V /| |__| | |_) \__ \   | |_| | (_) | |_| |
              |_____/ \___| \_/  \____/| .__/|___/    \__, |\___/ \__,_|
                                       | | _           __/ |_ ___
                                       |_|| |         |___/ _|__ \
                      ___ _ __   ___  __ _| | __     ___ | |_   ) |
                     / __| '_ \ / _ \/ _`` | |/ /    / _ \|  _| / /
                     \__ \ |_) |  __/ (_| |   <    | (_) | |  |_|
                     |___/ .__/ \___|\__,_|_|\_\    \___/|_|  (_)
                         | |
                         |_|
";

$LineCounts | Write-SlideSection -Text $SlideTitle -Complete;
