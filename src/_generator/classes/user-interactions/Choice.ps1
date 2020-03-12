
class Choice
{
    #region Properties

    [char] $Key;
    [string] $Description;
    [bool] $IsDefault;

    #endregion Properties

    #region Constructors

    Choice() { }

    Choice([char] $Key, [string] $Description, [bool] $IsDefault)
    {
        if ($IsDefault)
        {
            $this.Key = $Key.ToString().ToUpper();
        }
        else
        {
            $this.Key = $Key.ToString().ToLower();
        }

        $this.Description = $Description;
        $this.IsDefault = $IsDefault;
    }

    Choice([char] $Key, [string] $Description)
    {
        $this.Key = $Key.ToString().ToLower();
        $this.Description = $Description;
        $this.IsDefault = $false;
    }

    #endregion Constructors

    #region Methods



    #endregion Methods
}

class ChoiceCollection
{
    #region Properties

    [System.Collections.Generic.List[Choice]] $Choices;

    #endregion Properties

    #region Constructors

    ChoiceCollection()
    {
        $this.Choices = [System.Collections.Generic.List[Choice]]::new();
    }

    ChoiceCollection([System.Collections.Generic.List[Choice]] $Choices)
    {
        $this.Choices = $Choices;
    }

    #endregion Constructors

    #region Methods

    [ChoiceCollection] Add([Choice] $Choice)
    {
        $this.Choices.Add($Choice);

        return $this;
    }

    [ChoiceCollection] Add([char] $Key, [string] $Description, [bool] $IsDefault)
    {
        $this.Add([Choice]::new($Key, $Description, $IsDefault));

        return $this;
    }

    [ChoiceCollection] Add([char] $Key, [string] $Description)
    {
        $this.Add([Choice]::new($Key, $Description, $false));

        return $this;
    }

    [int] Count()
    {
        return $this.Choices.Count;
    }

    [System.Collections.Generic.List[Choice]] Where([ScriptBlock] $WhereClause)
    {
        return $this.Choices.Where($WhereClause);
    }

    [System.Collections.Generic.List[char]] Keys()
    {
        return $this.Choices | Select-Object -ExpandProperty Key.Choices;
    }

    #endregion Methods
}
