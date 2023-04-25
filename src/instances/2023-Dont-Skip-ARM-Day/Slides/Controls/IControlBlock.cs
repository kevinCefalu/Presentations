
using Spectre.Console;

namespace DevOpsSprint.Presentation.Slides.Controls;

public interface IControlBlock
{
    int Ratio { get; }
    ControlPadding Padding { get; }

    Layout Build();
}

public interface IJustifiedControlBlock : IControlBlock
{
    Justify Justification { get; }
}

public interface IFigletBlock : IJustifiedControlBlock
{
    string Text { get; set; }

    ConsoleColor Color { get; }
}

public interface IMarkupBlock : IJustifiedControlBlock
{

}

public interface ITableBlock : IControlBlock
{
    List<Column> Columns { get; }

    List<string[]> Rows { get; }
}
