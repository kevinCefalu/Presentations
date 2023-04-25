
using Spectre.Console;
using YamlDotNet.Serialization;

namespace DevOpsSprint.Presentation.Slides.Controls;

public class MarkupBlock : IMarkupBlock
{
    [YamlIgnore]
    public Markup Text { get; private set; } = new(String.Empty);

    public Justify Justification { get; private set; } = Justify.Left;

    public ControlPadding Padding { get; private set; } = new(0, 0);

    public string Content { get; private set; } = String.Empty;

    [YamlMember(Alias = "LayoutRatio")]
    public int Ratio { get; private set; }

    public Layout Build()
    {
        Text = new Markup(Content).Justify(Justification);

        return new Layout(new Padder(Text, Padding.ToPadding())).Ratio(Ratio);
    }
}
