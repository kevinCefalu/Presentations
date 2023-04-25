
using Spectre.Console;
using YamlDotNet.Serialization;

namespace DevOpsSprint.Presentation.Slides.Controls;

public class FigletBlock : IFigletBlock
{
    [YamlIgnore]
    public FigletText Title { get; private set; } = new(String.Empty);

    [YamlIgnore]
    public string Text { get; set; } = String.Empty;

    public Justify Justification { get; private set; } = Justify.Left;

    public ConsoleColor Color { get; private set; } = ConsoleColor.Green;

    public ControlPadding Padding { get; private set; } = new(0, 0);

    [YamlMember(Alias = "LayoutRatio")]
    public int Ratio { get; private set; } = 1;

    public Layout Build()
    {
        Title = new FigletText(Text).Justify(Justification).Color(Color);

        return new Layout(new Padder(Title, Padding.ToPadding())).Ratio(Ratio);
    }
}
