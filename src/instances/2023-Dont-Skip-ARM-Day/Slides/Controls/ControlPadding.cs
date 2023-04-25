
using Spectre.Console;

namespace DevOpsSprint.Presentation.Slides.Controls;

public class ControlPadding
{
    public int Horizontal { get; set; }

    public int Vertical { get; set; }

    public ControlPadding() { }

    public ControlPadding(int horizontal, int vertical)
    {
        Horizontal = horizontal;
        Vertical = vertical;
    }

    public Padding ToPadding()
    {
        return new Padding(Horizontal, Vertical);
    }
}
