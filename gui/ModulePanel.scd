// Module Panel Component
~makeModulePanel = { |parent|
  var view, layout, modules, vco1, vco2;
  
  // Initialize VCO synths
  vco1 = ~vcoInstr.reproduce;
  vco2 = ~vcoInstr.reproduce;
  
  view = View(parent)
    .background_(Color.grey(0.8));
    
  layout = GridLayout()
    .margins_(10)
    .spacing_(5);
    
  // Create VCO1 section
  modules = [
    ["VCO 1", [
      ["Frequency", EZKnob(nil, 45@16, "freq", \freq,
        {|ez| vco1.theSynth.setArgs(\freq, ez.value)}, 440, false, 40, 40)],
      ["Fine Tune", EZKnob(nil, 45@16, "tune", [0.5,2,\exp],
        {|ez| vco1.theSynth.setArgs(\tune, ez.value)}, 1, false, 40, 40)],
      ["FM Amount", EZKnob(nil, 45@16, "fm", [0,32,\lin],
        {|ez| vco1.theSynth.setArgs(\fm, ez.value)}, 0, false, 40, 40)],
      ["Wave", PopUpMenu()
        .items_(["Sine", "Saw", "Pulse", "Sync"])
        .action_({|m|
          var waves = [\vco_sine, \vco_saw, \vco_pulse, \vco_ssync];
          vco1.theSynth.synthDefName = waves[m.value];
          vco1.theSynth.playSynth;
        })
      ]
    ]],
    
    ["VCO 2", [
      ["Frequency", EZKnob(nil, 45@16, "freq", \freq,
        {|ez| vco2.theSynth.setArgs(\freq, ez.value)}, 440, false, 40, 40)],
      ["Fine Tune", EZKnob(nil, 45@16, "tune", [0.5,2,\exp],
        {|ez| vco2.theSynth.setArgs(\tune, ez.value)}, 1, false, 40, 40)],
      ["FM Amount", EZKnob(nil, 45@16, "fm", [0,32,\lin],
        {|ez| vco2.theSynth.setArgs(\fm, ez.value)}, 0, false, 40, 40)],
      ["Wave", PopUpMenu()
        .items_(["Sine", "Saw", "Pulse", "Sync"])
        .action_({|m|
          var waves = [\vco_sine, \vco_saw, \vco_pulse, \vco_ssync];
          vco2.theSynth.synthDefName = waves[m.value];
          vco2.theSynth.playSynth;
        })
      ]
    ]]
  ];
  
  // Create module sections
  modules.do({ |module, i|
    var name = module[0];
    var controls = module[1];
    var moduleView = View()
      .background_(Color.grey(0.9));
      
    var moduleLayout = VLayout()
      .margins_(5)
      .spacing_(5);
      
    // Add module title
    moduleLayout.add(
      StaticText()
        .string_(name)
        .font_(Font("Helvetica", 12, true))
        .align_(\center)
    );
    
    // Add controls
    controls.do({ |control|
      var controlLayout = HLayout();
      controlLayout.add(StaticText().string_(control[0]));
      controlLayout.add(control[1]);
      moduleLayout.add(controlLayout);
    });
    
    // Add play/stop buttons
    moduleLayout.add(
      HLayout(
        Button()
          .states_([["Play"], ["Stop", Color.black, Color.red]])
          .action_({|btn|
            if(btn.value == 1) {
              if(name == "VCO 1") {
                vco1.theSynth.playSynth;
              } {
                vco2.theSynth.playSynth;
              }
            } {
              if(name == "VCO 1") {
                vco1.theSynth.stopSynth;
              } {
                vco2.theSynth.stopSynth;
              }
            }
          }),
        Button()
          .states_([["Mute"], ["Unmute", Color.black, Color.yellow]])
          .action_({|btn|
            if(name == "VCO 1") {
              vco1.theSynth.runSynth(btn.value == 0);
            } {
              vco2.theSynth.runSynth(btn.value == 0);
            }
          })
      )
    );
    
    moduleView.layout = moduleLayout;
    layout.add(moduleView, i.div(2), i % 2);
  });
  
  view.layout = layout;
  view
};
