
using DevOpsSprint.Presentation;
using DevOpsSprint.Presentation.Configuration;
using DevOpsSprint.Presentation.Slides;
using DevOpsSprint.Presentation.Slides.Controls;
using System.Diagnostics;
using System.Runtime.InteropServices;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

[DllImport("user32.dll")]
static extern bool ShowWindow(IntPtr hWnd, int cmdShow);

// Maximize window
ShowWindow(Process.GetCurrentProcess().MainWindowHandle, 3);

// Create the Yaml deserializer
IDeserializer deserializer = new DeserializerBuilder()
    .WithNamingConvention(PascalCaseNamingConvention.Instance)
    .WithTypeMapping<ISlide, Slide>()
    .WithTagMapping("!FigletBlock", typeof(FigletBlock))
    .WithTagMapping("!MarkupBlock", typeof(MarkupBlock))
    .WithTagMapping("!TableBlock", typeof(TableBlock))
    .Build();

// Open the presentation configuration file
using StreamReader reader = new(@"configuration.yaml");

// Deserialize the presentation configuration
PresentationConfiguration presentationConfiguration = deserializer.Deserialize<PresentationConfiguration>(reader);

// Start Presentation
new PresentationEngine(presentationConfiguration).Render();
