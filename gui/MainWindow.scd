// Main Window Setup
~makeMainWindow = {
  var window, mainView, modulePanel, effectsPanel, matrixPanel, lfoPanel, mixerPanel, presetPanel;
  
  window = Window.new("Xynthi", Rect(100, 100, 1200, 800))
    .front
    .alwaysOnTop_(true);
    
  mainView = View(window);
  modulePanel = ~makeModulePanel.(mainView);
  effectsPanel = ~makeEffectsPanel.(mainView);
  matrixPanel = ~makeMatrixPanel.(mainView);
  lfoPanel = ~makeLFOPanel.(mainView);
  mixerPanel = ~makeMixerPanel.(mainView);
  presetPanel = ~makePresetPanel.(mainView);
    
  mainView.layout_(VLayout(
    HLayout(
      StaticText().string_("XYNTHI").font_(Font("Helvetica", 24)),
      nil // Spacer
    ).margins_(20),
    HLayout(
      VLayout(modulePanel, mixerPanel),
      VLayout(matrixPanel, lfoPanel),
      VLayout(effectsPanel, presetPanel)
    ).spacing_(10)
  ));
    
  window.onClose_({
    // Cleanup code here
  });
  
  window
};
