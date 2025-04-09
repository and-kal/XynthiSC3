// Mixer Panel
~makeMixerPanel = { |parent|
  var view, layout, channels = 4;
  
  view = View(parent).background_(Color.grey(0.8));
  layout = HLayout().margins_(10).spacing_(5);
  
  layout.add(StaticText().string_("MIXER")
    .font_(Font("Helvetica", 12, true))
    .align_(\center));
    
  channels.do { |i|
    layout.add(
      View().layout_(
        VLayout(
          StaticText().string_("Ch " ++ (i + 1)).align_(\center),
          Slider().orientation_(\vertical).action_({ |sl| }),
          Knob().action_({ |k| /* Pan control */ }),
          Button().states_([["M"], ["M", Color.white, Color.red]])
        )
      ).background_(Color.grey(0.9))
    );
  };
  
  // Master section
  layout.add(
    View().layout_(
      VLayout(
        StaticText().string_("Master").align_(\center),
        Slider().orientation_(\vertical),
        Button().states_([["M"], ["M", Color.white, Color.red]])
      )
    ).background_(Color.grey(0.9))
  );
  
  view.layout = layout;
  view
};
