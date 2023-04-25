
using DevOpsSprint.Presentation.Slides.Controls;
using Spectre.Console;

namespace DevOpsSprint.Presentation.Slides
{
    public interface ISlide
    {
        List<IControlBlock> Content { get; }

        string SlideListTitle { get; }

        string Title { get; }

        void Render(Layout layout);
    }
}
