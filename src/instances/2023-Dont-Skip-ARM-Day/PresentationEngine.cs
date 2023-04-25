
using DevOpsSprint.Presentation.Configuration;
using Spectre.Console;
using Constants = DevOpsSprint.Presentation.Configuration.Constants;

namespace DevOpsSprint.Presentation
{
    internal class PresentationEngine
    {
        private readonly Layout PresentationLayout = new();

        private readonly Tree SlideTree = new(Constants.SLIDE_TREE_LABEL);

        private Layout ContentLayout => PresentationLayout[Constants.SLIDE_CONTENT_LAYOUT_NAME];

        private readonly PresentationConfiguration Config;

        public PresentationEngine(PresentationConfiguration slides)
        {
            Config = slides;

            GenerateMasterLayout();
            RenderSlideList();
        }

        private void GenerateMasterLayout()
        {
            MasterLayoutRatios config = Config.GlobalPresentationSettings.MasterLayoutRatios;

            PresentationLayout.SplitColumns(
                new Layout(Constants.SLIDE_NAVIGATION_LAYOUT_NAME).Ratio(config.Navigation).SplitRows(
                    new Layout(Constants.SLIDE_LIST_LAYOUT_NAME).Ratio(config.SlideList),
                    new Layout(Constants.SLIDE_PROGRESS_LAYOUT_NAME).Ratio(config.SlideProgress)
                ),
                new Layout(Constants.SLIDE_CONTENT_LAYOUT_NAME).Ratio(config.Content)
            );
        }

        private void RenderSlideList(int slideIndex = 0)
        {
            string[] slideTitlesList = Config.GetSlideListTitles(slideIndex);

            SlideTree.Nodes.Clear();
            SlideTree.Guide(TreeGuide.Line).AddNodes(slideTitlesList);

            Panel SlideTreePanel = new Panel(SlideTree).Expand();
            PresentationLayout[Constants.SLIDE_LIST_LAYOUT_NAME].Update(SlideTreePanel);

            RenderSlideProgress(slideIndex, slideTitlesList.Length);
        }

        private void RenderSlideProgress(int slideIndex, int maxSlideCount)
        {
            SlideProgressSettings config = Config.GlobalPresentationSettings.SlideProgress;

            string barChartLabel = "[dim][green]Left Arrow[/]: Previous" +
                "\n[green]Right Arrow[/]: Next" +
                "\n[green]Escape[/]: End[/]" +
                $"\n\n[green]{config.Label}[/]";

            BarChart SlideProgressBarChart = new BarChart()
                .Width(config.Width).Label(barChartLabel)
                .AddItem(" ", (slideIndex + 1), config.BarColor);

            // Hidden bar to allow full-width display of progress bar
            SlideProgressBarChart.AddItem(String.Empty, maxSlideCount, Color.Black);

            SlideProgressBarChart.LabelAlignment = config.Justification;

            PresentationLayout[Constants.SLIDE_PROGRESS_LAYOUT_NAME].Update(
                new Panel(SlideProgressBarChart).Expand()
            );
        }

        private void RenderSlide(int slideIndex)
        {
            Config.RenderSlide(ContentLayout, slideIndex);
        }

        public void Render()
        {
            for (int i = 1; i < Config.GlobalPresentationSettings.StartingTextTopPadding; i++) { AnsiConsole.WriteLine(); }
            FigletText startPresentation = new FigletText(Config.GlobalPresentationSettings.StartingText).Centered();
            AnsiConsole.Write(startPresentation);

            ConsoleKeyInfo? readKey = AnsiConsole.Console.Input.ReadKey(true);

            AnsiConsole.Console.Clear();

            AnsiConsole.Live(PresentationLayout)
                .Start(ctx =>
                {
                    int slideIndex = 0;

                    RenderSlideList(slideIndex);
                    RenderSlide(slideIndex);

                    ctx.Refresh();

                    do
                    {
                        ConsoleKeyInfo? readKey = AnsiConsole.Console.Input.ReadKey(true);

                        if (readKey is not null)
                        {
                            if (readKey.Value.Key == ConsoleKey.LeftArrow && slideIndex > 0)
                            {
                                slideIndex--;
                            }
                            else if (readKey.Value.Key == ConsoleKey.RightArrow && slideIndex < Config.Count - 1)
                            {
                                slideIndex++;
                            }
                            else if (readKey.Value.Key == ConsoleKey.Escape)
                            {
                                break;
                            }
                        }

                        if (slideIndex >= 0 && slideIndex < Config.Count)
                        {
                            RenderSlideList(slideIndex);
                            RenderSlide(slideIndex);

                            ctx.Refresh();
                        }
                    }
                    while (true);
                });

            AnsiConsole.Console.Clear();
        }
    }
}
