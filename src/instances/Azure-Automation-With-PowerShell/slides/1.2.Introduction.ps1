
. "$PSScriptRoot\..\utilities\Get-IndentedText.ps1";
. "$PSScriptRoot\..\utilities\Get-WrappedText.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideSection.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideTable.ps1";

$LineCounts = [PSCustomObject] @{
    Available = 34;
    Used = 0;
};

$SlideTitle = @"
     _  __          _          _____      __      _
    | |/ /         (_)        / ____|    / _|    | |
    | ' / _____   ___ _ __   | |     ___| |_ __ _| |_   _
    |  < / _ \ \ / / | '_ \  | |    / _ \  _/ _`` | | | | |
    | . \  __/\ V /| | | | | | |___|  __/ || (_| | | |_| |
    |_|\_\___| \_/ |_|_| |_|  \_____\___|_| \__,_|_|\__,_|

    Netchex DevOps Engineer II | DevOps Technology Team Lead
"@;

$Summary = 'Born on New Year''s Day, Kevin is a DevOps Engineer who spends his days improving life for his fellow developers and system administrators through automation for Netchex, a cloud-based human resource and payroll management solution. His passion motivates him to continually learn new concepts and technologies in order to apply them to the betterment of his colleagues. Outside of work, Kevin is a loving husband and dad to his dogs: Ajax (yes, that stands for Asynchronous Javascript and XML) and Callie. Kevin brings his love of development into projects like IoT devices or chatbots used in "pen and paper" style tabletop games. He is a capable chef, carpenter, electrician, and plumber who hopes to someday personally build a home for his family.';

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
    -Title ('Summary' | Get-IndentedText) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 2);

$LineCounts | Write-SlideTable @Table -Complete;
