
using DevOpsSprint.Presentation.Slides;
using Spectre.Console;

namespace DevOpsSprint.Presentation.Configuration;

public class PresentationConfiguration
{
    public GlobalSettings GlobalPresentationSettings { get; private set; } = new();

    public List<ISlide> Slides { get; private set; } = new();

    public int Count => Slides.Count;
}

public static class PresentationConfigurationExtensions
{
    public static string[] GetSlideListTitles(this PresentationConfiguration config, int selectedIndex = 0)
    {
        ConsoleColor slideColor = config.GlobalPresentationSettings.SelectedSlideTitleColor;

        return config.Slides.Select((slide, index) =>
        {
            string title = !String.IsNullOrWhiteSpace(slide.SlideListTitle) ? slide.SlideListTitle : slide.Title;

            return selectedIndex == index ? $"[{slideColor}]{title}[/]" : title;
        }).ToArray();
    }

    public static void RenderSlide(this PresentationConfiguration config, Layout layout, int selectedIndex)
    {
        config.Slides[selectedIndex].Render(layout);
    }
}
