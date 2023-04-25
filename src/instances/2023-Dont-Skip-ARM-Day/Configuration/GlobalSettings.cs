
namespace DevOpsSprint.Presentation.Configuration;

public class GlobalSettings
{
    public string StartingText { get; set; } = "Press any key to start presentation";

    public int StartingTextTopPadding { get; set; } = 18;

    public ConsoleColor SelectedSlideTitleColor { get; set; } = ConsoleColor.Green;

    public MasterLayoutRatios MasterLayoutRatios { get; set; } = new();

    public SlideProgressSettings SlideProgress { get; set; } = new();
}
