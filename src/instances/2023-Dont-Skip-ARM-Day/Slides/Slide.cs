
using DevOpsSprint.Presentation.Slides.Controls;
using Spectre.Console;

namespace DevOpsSprint.Presentation.Slides;

public class Slide : ISlide
{
    public string Title { get; private set; } = String.Empty;

    public string SlideListTitle { get; private set; } = String.Empty;

    public List<IControlBlock> Content { get; private set; } = new();

    public void Render(Layout layout)
    {
        Layout content = new Layout().SplitRows(Content.Select(control =>
        {

            if (control is FigletBlock && String.IsNullOrWhiteSpace(((IFigletBlock)control).Text))
            {
                ((IFigletBlock)control).Text = Title;
            }

            return control.Build();

        }).ToArray());

        layout.Update(content);
    }
}
