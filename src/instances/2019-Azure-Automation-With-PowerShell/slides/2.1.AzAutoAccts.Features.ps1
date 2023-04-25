
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
                   _                        _   _                                                 _
        /\        | |                      | | (_)                 /\                            | |
       /  \  _   _| |_ ___  _ __ ___   __ _| |_ _  ___  _ __      /  \   ___ ___ ___  _   _ _ __ | |_ ___
      / /\ \| | | | __/ _ \| '_ `` _ \ / _`` | __| |/ _ \| '_ \    / /\ \ / __/ __/ _ \| | | | '_ \| __/ __|
     / ____ \ |_| | || (_) | | | | | | (_| | |_| | (_) | | | |  / ____ \ (_| (_| (_) | |_| | | | | |_\__ \
    /_/    \_\__,_|\__\___/|_| |_| |_|\__,_|\__|_|\___/|_| |_| /_/    \_\___\___\___/ \__,_|_| |_|\__|___/
"@;

$Summary = 'Azure Automation delivers a cloud-based automation & configuration service that provides consistent management of all your Windows & Linux environments, in Azure & On-Premise. It consists of process automation, update management, & configuration features. It provides complete control during deployment, operations, & decommissioning of workloads & resources.';

$Table = @{
    Title = 'Features';
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
            Name = 'Process Automation';
            Value = 'Orchestrate processes using Graphical, PowerShell, & Python "Runbooks"';
        },
        [PSCustomObject] @{
            Name = 'Configuration Management';
            Value = 'Collect inventory, track changes, & configure desired state of Virtual Machines';
        },
        [PSCustomObject] @{
            Name = 'Update Management';
            Value = 'Assess compliance & schedule update installations on Virtual Machines';
        },
        [PSCustomObject] @{
            Name = 'Shared Capabilities';
            Value = @(
                'Role-Based Access Control',
                'Secure, global store for Variables, Credentials, Certificates, & Connections',
                'Flexible Scheduling',
                'Shared Modules',
                'Source Control Support',
                'Auditing',
                'Tags'
            );
        }
    );
};

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Summary' | Get-IndentedText) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 2);

$LineCounts | Write-SlideTable @Table -WaitBetweenRows -Complete;
