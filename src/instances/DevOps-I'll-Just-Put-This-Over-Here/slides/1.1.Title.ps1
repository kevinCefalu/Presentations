
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideSection.ps1";

$LineCounts = [PSCustomObject] @{
    Available = [Console]::WindowHeight - 2;
    Used = 0;
};

$SlideTitle = "


        __          ___           _       _   _                _  _                  _   __
        \ \        / / |         | |     | | | |             _| || |_   ____   ___  (_) / /
         \ \  /\  / /| |__   __ _| |_    | |_| |__   ___    |_  __  _| / __ \ ( _ )    / /
          \ \/  \/ / | '_ \ / _`` | __|   | __| '_ \ / _ \    _| || |_ / / _`` |/ _ \/\ / /
           \  /\  /  | | | | (_| | |_    | |_| | | |  __/   |_  __  _| | (_| | (_>  </ / _
            \/  \/   |_|_|_|\__,_|\__|   _\__|_| |_|\___|     |_||_|  \ \__,_|\___/\/_/ (_)                ___
           (_)       |  __ \            / __ \                    /\   \____/                             |__ \
            _ ___    | |  | | _____   _| |  | |_ __  ___         /  \   _ __  _   ___      ____ _ _   _ ___  ) |
           | / __|   | |  | |/ _ \ \ / / |  | | '_ \/ __|       / /\ \ | '_ \| | | \ \ /\ / / _`` | | | / __|/ /
           | \__ \   | |__| |  __/\ V /| |__| | |_) \__ \_     / ____ \| | | | |_| |\ V  V / (_| | |_| \__ \_|
           |_|___/   |_____/ \___| \_/  \____/| .__/|___( )   /_/    \_\_| |_|\__, | \_/\_/ \__,_|\__, |___(_)
                                              | |       |/                     __/ |               __/ |
                                              |_|                             |___/               |___/


        A Presentation on DevOps, and why you should care

        By Kevin Cefalu | Netchex DevOps Senior Engineer & Team Lead
";

$LineCounts | Write-SlideSection -Text $SlideTitle -Complete;
