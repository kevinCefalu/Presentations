
# TODO: Add indention to all writes

class ConsoleWriter
{
    #region Properties

    [int] $CurrentIndention;

    #endregion Properties

    #region Constructors

    ConsoleWriter()
    {
        $this.CurrentIndention = 0;
    }

    ConsoleWriter([int] $CurrentIndention)
    {
        $this.CurrentIndention = $CurrentIndention;
    }

    #endregion Constructors

    #region Methods

    [ConsoleWriter] WriteEmptyLines([int] $LineCount)
    {
        $LineCount++;

        for ($i = 1; $i -lt $LineCount; $i++)
        {
            [Console]::WriteLine();
        }

        return $this;
    }

    [ConsoleWriter] Write([string] $Text)
    {
        [Console]::Write($Text);

        return $this;
    }

    [ConsoleWriter] Write([string] $Text, [ConsoleColor] $ForegroundColor)
    {
        [Console]::ForegroundColor = $ForegroundColor;

        $this.Write($Text);

        [Console]::ResetColor();

        return $this;
    }

    [ConsoleWriter] WriteWithPrefixLines([string] $Text, [int] $LineCount)
    {
        $this.
            WriteEmptyLines($LineCount).
            Write($Text);

        return $this;
    }

    [ConsoleWriter] WriteWithPrefixLines([string] $Text, [int] $LineCount, [ConsoleColor] $ForegroundColor)
    {
        $this.
            WriteEmptyLines($LineCount).
            Write($Text, $ForegroundColor);

        return $this;
    }

    [ConsoleWriter] WriteWithSuffixLines([string] $Text, [int] $LineCount)
    {
        $this.
            Write($Text).
            WriteEmptyLines($LineCount);

        return $this;
    }

    [ConsoleWriter] WriteWithSuffixLines([string] $Text, [int] $LineCount, [ConsoleColor] $ForegroundColor)
    {
        $this.
            Write($Text, $ForegroundColor).
            WriteEmptyLines($LineCount);

        return $this;
    }

    [ConsoleWriter] Write([string] $Text, [int] $PrefixLineCount, [int] $SuffixLineCount)
    {
        $this.
            WriteEmptyLines($PrefixLineCount).
            Write($Text).
            WriteEmptyLines($SuffixLineCount);

        return $this;
    }

    [ConsoleWriter] Write([string] $Text, [int] $PrefixLineCount, [int] $SuffixLineCount, [ConsoleColor] $ForegroundColor)
    {
        $this.
            WriteEmptyLines($PrefixLineCount).
            Write($Text, $ForegroundColor).
            WriteEmptyLines($SuffixLineCount);

        return $this;
    }

    [ConsoleWriter] WriteLine([string] $Text)
    {
        [Console]::WriteLine($Text);

        return $this;
    }

    [ConsoleWriter] WriteLine([string] $Text, [ConsoleColor] $ForegroundColor)
    {
        [Console]::ForegroundColor = $ForegroundColor;

        $this.WriteLine($Text);

        [Console]::ResetColor();

        return $this;
    }

    [ConsoleWriter] WriteLineWithPrefixLines([string] $Text, [int] $LineCount)
    {
        $this.
            WriteEmptyLines($LineCount).
            WriteLine($Text);

        return $this;
    }

    [ConsoleWriter] WriteLineWithPrefixLines([string] $Text, [int] $LineCount, [ConsoleColor] $ForegroundColor)
    {
        $this.
            WriteEmptyLines($LineCount).
            WriteLine($Text, $ForegroundColor);

        return $this;
    }

    [ConsoleWriter] WriteLineWithSuffixLines([string] $Text, [int] $LineCount)
    {
        $this.
            WriteLine($Text).
            WriteEmptyLines($LineCount);

        return $this;
    }

    [ConsoleWriter] WriteLineWithSuffixLines([string] $Text, [int] $LineCount, [ConsoleColor] $ForegroundColor)
    {
        $this.
            WriteLine($Text, $ForegroundColor).
            WriteEmptyLines($LineCount);

        return $this;
    }

    [ConsoleWriter] WriteLine([string] $Text, [int] $PrefixLineCount, [int] $SuffixLineCount)
    {
        $this.
            WriteEmptyLines($PrefixLineCount).
            WriteLine($Text).
            WriteEmptyLines($SuffixLineCount);

        return $this;
    }

    [ConsoleWriter] WriteLine([string] $Text, [int] $PrefixLineCount, [int] $SuffixLineCount, [ConsoleColor] $ForegroundColor)
    {
        $this.
            WriteEmptyLines($PrefixLineCount).
            WriteLine($Text, $ForegroundColor).
            WriteEmptyLines($SuffixLineCount);

        return $this;
    }

    #endregion Methods
}
