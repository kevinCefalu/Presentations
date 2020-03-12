
. "$PSScriptRoot\..\utilities\Get-IndentedText.ps1";
. "$PSScriptRoot\..\utilities\Get-WrappedText.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideSection.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideTable.ps1";

$LineCounts = [PSCustomObject] @{
    Available = [Console]::WindowHeight - 1;
    Used = 0;
};

$SlideTitle = "
        __          ___                                   _____ ___
        \ \        / / |                                 |_   _|__ \
         \ \  /\  / /| |__   ___       __ _ _ __ ___       | |    ) |
          \ \/  \/ / | '_ \ / _ \     / _`` | '_ `` _ \      | |   / /
           \  /\  /  | | | | (_) |   | (_| | | | | | |    _| |_ |_|
            \/  \/   |_| |_|\___/     \__,_|_| |_| |_|   |_____|(_)
";

$Summary = (
    'Born on New Year''s Day, Kevin is a DevOps Engineer who spends his days ' +
    'improving life for his fellow developers and system administrators through ' +
    'automation for Netchex, a cloud-based human resource and payroll management ' +
    'solution. His passion motivates him to continually learn new concepts and ' +
    'technologies in order to apply them to the betterment of his colleagues. '
);

$Table = @{
    Title = 'Contact Information';
    Headers = @(
        [PSCustomObject] @{
            Display = 'Name';
            MapTo = 'Name';
        },
        [PSCustomObject] @{
            Display = 'Value';
            MapTo = 'Value';
        }
    );
    Rows = @(
        [PSCustomObject] @{
            Name = 'E-Mail';
            Value = 'Kevin.Cefalu@gmail.com';
        },
        [PSCustomObject] @{
            Name = 'GitHub';
            Value = 'https://github.com/KevinCefalu/';
        },
        [PSCustomObject] @{
            Name = 'LinkedIn';
            Value = 'https://www.linkedin.com/in/Kevin-Cefalu/';
        },
        [PSCustomObject] @{
            Name = 'Twitter';
            Value = 'https://twitter.com/KevinCefalu/';
        }
    );
};

$LineCounts.Used = $LineCounts | Write-SlideSection -Text $SlideTitle;

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Summary' | Get-IndentedText -IndentBy 8) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6);

$LineCounts | Write-SlideTable @Table -IndentBy 8 -Complete;
