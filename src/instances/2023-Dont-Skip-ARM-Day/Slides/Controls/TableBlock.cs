
using Spectre.Console;
using YamlDotNet.Serialization;

namespace DevOpsSprint.Presentation.Slides.Controls;

public class TableBlock : ITableBlock
{
    [YamlIgnore]
    private Table Table = new();

    public ControlPadding Padding { get; private set; } = new(0, 0);

    [YamlMember(Alias = "LayoutRatio")]
    public int Ratio { get; set; } = 1;

    public List<Column> Columns { get; private set; } = new();

    public List<string[]> Rows { get; private set; } = new();

    public Layout Build()
    {
        Table = new();

        Columns.ForEach(c => Table.AddColumn(c.Build()));
        Rows.ForEach(r => Table.AddRow(r));

        return new Layout(new Padder(Table, Padding.ToPadding())).Ratio(Ratio);
    }
}

public class Column
{
    public string Text { get; set; } = String.Empty;

    public Justify Justification { get; set; } = Justify.Left;

    public TableColumn Build() => new TableColumn(Text).Alignment(Justification);
}
