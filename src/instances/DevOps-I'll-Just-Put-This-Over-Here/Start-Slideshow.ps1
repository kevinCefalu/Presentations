
$Slides = Get-ChildItem -Path (
    Join-Path $PSScriptRoot -ChildPath ".\slides\"
);

foreach ($Slide in $Slides)
{
    Clear-Host;

    . ".\slides\$($Slide.Name)";
}
