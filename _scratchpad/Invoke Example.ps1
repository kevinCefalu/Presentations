
. "$PSScriptRoot\Deploy.init.ps1";

foreach ($Step in ($Script:Configuration.Steps.Where({ $_.Enabled })))
{
    Invoke-Step `
        -Title $Step.Title `
        -ScriptFile "$Script:StepRoot\$($Step.ScriptPath)" `
        -Arguments $Step.Arguments;
}
