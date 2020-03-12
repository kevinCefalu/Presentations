
class PsiConsole
{
    #region Properties

    hidden static [Diagnostics.ProcessWindowStyle] $DefaultWindowStyle = 'Maximized';

    hidden static [object[]] $DefaultProcessArguments = @(
        '-NoProfile',
        '-ExecutionPolicy RemoteSigned'
    );

    hidden static [HashTable] $DefaultColors = @{
        Foreground = [ConsoleColor]::White;
        Background = [ConsoleColor]::Blue;
    };

    [ValidateSet('PwSh', 'WinPS')]
    [string] $ConsoleType = 'PwSh';

    [Diagnostics.ProcessWindowStyle] $WindowStyle = [PsiConsole]::DefaultWindowStyle;

    [object[]] $ProcessArguments = @(
        [PsiConsole]::DefaultProcessArguments,
        "-CustomPipeName '$($this.PipeName)'"
    );

    [HashTable] $Colors = [PsiConsole]::DefaultColors;

    [string] $PipeName = "Psi.Console-$((New-Guid).Guid)";

    [Diagnostics.Process] $PresentationProcess;

    #endregion Properties

    #region Constructors

    PsiConsole()
    {
        $this.ResetDefaults();
    }

    #endregion Constructors

    #region Methods

    [PsiConsole] ResetDefaultWindowStyle()
    {
        $this.WindowStyle = [PsiConsole]::DefaultWindowStyle;

        return $this;
    }

    [PsiConsole] ResetDefaultProcessArguments()
    {
        $this.ProcessArguments = [PsiConsole]::DefaultProcessArguments;

        return $this;
    }

    [PsiConsole] ResetDefaultColors()
    {
        $this.Colors = [PsiConsole]::DefaultColors;

        return $this;
    }

    [PsiConsole] ResetDefaults()
    {
        return $this.
            ResetDefaultWindowStyle().
            ResetDefaultProcessArguments().
            ResetDefaultColors();
    }

    [PsiConsole] Start()
    {
        $this.ProcessArguments += "-Command {
            [Console]::ForegroundColor = [ConsoleColor]::$($this.Colors.Foreground);
            [Console]::BackgroundColor = [ConsoleColor]::$($this.Colors.Background);
            Read-Host;
        }";

        $this.PresentationProcess = Start-Process `
            -FilePath $this.ConsoleType `
            -ArgumentList ($this.ProcessArguments -join ' ') `
            -WindowStyle $this.WindowStyle `
            -PassThru;

        return $this;
    }

    <# [PsiConsole] SendCommand([ScriptBlock] $Command, [object[]] $Arguments)
    {
        Enter-PSHostProcess -CustomPipeName $this.PipeName;

        $Command.InvokeReturnAsIs($Arguments);

        Exit-PSHostProcess;

        return $this;
    } #>

    [void] Stop()
    {
        $this.PresentationProcess.Kill();
        $this.PresentationProcess.Close();
        $this.PresentationProcess.Dispose();
    }

    #endregion Methods
}
