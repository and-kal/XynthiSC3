# xynthi-update

Update of Bhob Rainey's Xynthi

It was originally done in SuperCollider 2 and was macOS-only. The new version will be in SuperCollider 3 and is supposed to run cross-platform.

The original version and additional information can be found at [mockfuneral.github.io](https://mockfuneral.github.io/2020/12/11/xynthi).

## Roadmap

Roadmap is in the making, but I haven't yet gotten around getting an overview of this repo.

One task would be this: »[S]ince SC switched to .scd files instead of .rtf, many of the GUI elements have changed, and the fact that you can’t define classes on-the-fly in SC means that some custom classes would have to be converted to class-like structures like Events. A mildly nauseating set of tasks,« as Bhob Rainey wrote.

## Prompts

For an initial conversion of some of the .scd files to something SC3-compatible I used the following prompt on Anthropic Claude Sonnet 3.5 (new):

> This is a synthesizer/sound generator built in SuperCollider 2. I want to rewrite it so that it works with [SuperCollider 3](https://docs.supercollider.online/). One of the main issues is that SuperCollider 2 used cocoa as a UI library, while SuberCollider 3 is using Qt. So a lot of the UI stuff in `Xynthi_Run.scd` for example has to be rewritten for Qt. (Ideally, our SuperCollider program would then also run on Windows and Linux, while the cocoa part made it Mac-exclusive previously.) The good news is, that the sound producing part is extremely straightforward, e.g. the filters (`./modules/moogvcf.scd`), oscillators (`./modules/vco.scd`) or reverb (`./modules/scverb.scd`) are all pretty straightforward SynthDefs and the least amount of code to port. The application comes to life in the routing and interaction of elements (modules), which is largely driven by the UI. So the majority of work is really rewriting the UI part. Though we should also check, if maybe some of the synthdefs or other classes used in the .scd files are outdated. We can ignore the `./presets` folder for now.

In response these steps were generated:

### Migration Steps

1. Create Qt UI framework
2. Port control logic
3. Update sound engine
4. Test cross-platform
5. Add preset system

#### UI Components to Migrate

1. Core UI Classes to Replace:

- MultiPageLayout -> View
- SCButton -> Button
- SCStaticText -> StaticText
- SCNumberBox -> NumberBox
- SCSlider -> Slider
- SCRangeSlider -> RangeSlider
- SC2DSlider -> Slider2D
- SCEnvEditor -> EnvelopeView
- CocoaDialog -> Dialog

2. UI Layout Changes:

- Replace .flow with .layout
- Update window management
- Convert coordinate system
- Migrate event handling

#### Sound Components to Verify

1. SynthDefs to Check:

- MoogLadder compatibility
- EnvGen specifications
- Bus routing methods
- NodeProxy usage

2. Class Updates:

- Convert Event patterns
- Update control bus handling
- Verify node group behavior
