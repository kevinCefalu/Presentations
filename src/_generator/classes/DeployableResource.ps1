
class DeployableResource
{
    #region Properties

    [string] $FromDirectory;
    [string] $ToDirectory;
    [string] $FileName;

    #endregion Properties

    #region Constructors

    DeployableResource()
    {
        $this.FromDirectory = $null;
        $this.ToDirectory = $null;
        $this.FileName = $null;
    }

    DeployableResource([string] $FromDirectory, [string] $ToDirectory)
    {
        $this.FromDirectory = $FromDirectory;
        $this.ToDirectory = $ToDirectory;
        $this.FileName = $null;
    }

    DeployableResource([string] $FromDirectory, [string] $ToDirectory, [string] $FileName)
    {
        $this.FromDirectory = $FromDirectory;
        $this.ToDirectory = $ToDirectory;
        $this.FileName = $FileName;
    }

    #endregion Constructors

    #region Methods

    [bool] Validate()
    {
        $Success = $false;

        if (-not (Test-Path $this.FromDirectory))
        {
            throw "Deployable Resource `"From`" Directory ($($this.FromDirectory)) was not found.";
        }
        elseif (-not ([String]::IsNullOrEmpty($this.FileName)) -and
                -not (Test-Path "$($this.FromDirectory)\$($this.FileName)"))
        {
            throw "Deployable Resource File ($($this.FromDirectory)\$($this.FileName)) was not found.";
        }

        if (-not (Test-Path $this.ToDirectory))
        {
            New-Item $this.ToDirectory -ItemType Directory | Out-Null;

            $Script:ConsoleWriter.Write()
        }

        return $Success;
    }

    #endregion Methods
}
