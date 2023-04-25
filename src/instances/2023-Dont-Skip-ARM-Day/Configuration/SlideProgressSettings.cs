
using Spectre.Console;
using YamlDotNet.Serialization;

namespace DevOpsSprint.Presentation.Configuration;

public class SlideProgressSettings
{
    [YamlMember(Alias = "LabelText")]
    public string Label { get; set; } = Constants.SLIDE_PROGRESS_LABEL;

    [YamlMember(Alias = "LabelJustification")]
    public Justify Justification { get; set; } = Justify.Left;

    public int Width { get; set; } = 100;

    public ConsoleColor BarColor { get; set; } = ConsoleColor.Green;
}
