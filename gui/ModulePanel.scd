// Module Panel Component
~makeModulePanel = { |parent|
  var view, layout, modules;
  
  // Define module sections
  modules = [
    ["VCO 1", [
      ["Frequency", Knob()],
      ["Fine Tune", Knob()],
      ["Wave Shape", Knob()]
    ]],
    ["VCO 2", [
      ["Frequency", Knob()],
      ["Fine Tune", Knob()],
      ["Wave Shape", Knob()]
    ]],
    ["Filter", [
      ["Cutoff", Knob()],
      ["Resonance", Knob()],
      ["Mode", PopUpMenu()]
    ]],
    ["Envelope", [
      ["Attack", Knob()],
      ["Decay", Knob()],
      ["Sustain", Knob()],
      ["Release", Knob()]
    ]]
  ];
  
  view = View(parent)
    .background_(Color.grey(0.8));
    
  layout = GridLayout()
    .margins_(10)
    .spacing_(5);
    
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
    
    moduleView.layout = moduleLayout;
    layout.add(moduleView, i.div(2), i % 2);
  });
  
  view.layout = layout;
  view
};
