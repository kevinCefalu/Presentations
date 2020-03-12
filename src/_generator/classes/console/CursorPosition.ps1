
class CursorPosition
{
    #region Properties

    [int] $Row;
    [int] $Column;

    #endregion Properties

    #region Constructors

    CursorPosition()
    {
        $this.Row = [Console]::CursorTop;
        $this.Column = [Console]::CursorLeft;
    }

    CursorPosition([int] $Row, [int] $Column)
    {
        $this.Row = $Row;
        $this.Column = $Column;
    }

    #endregion Constructors

    #region Methods

    static [void] Set([int] $Row, [int] $Column)
    {
        [Console]::SetCursorPosition($Column, $Row);
    }

    [void] Restore()
    {
        [CursorPosition]::Set($this.Row, $this.Column);
    }

    #endregion Methods
}
