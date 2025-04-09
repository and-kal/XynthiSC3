// LFO Controls Panel
~makeLFOPanel = { |parent|
  var view, layout;
  
  view = View(parent).background_(Color.grey(0.8));
  layout = VLayout().margins_(10).spacing_(5);
  
  layout.add(StaticText().string_("LFO CONTROLS")
    .font_(Font("Helvetica", 12, true))
    .align_(\center));
    
  // Create 3 LFO sections
  3.do { |i|
    layout.add(
      View().layout_(
        VLayout(
          StaticText().string_("LFO " ++ (i + 1)).align_(\center),
          GridLayout.rows(
            [StaticText().string_("Rate"), Knob()],
            [StaticText().string_("Shape"), PopUpMenu().items_(["Sine", "Triangle", "Square", "Saw"])],
            [StaticText().string_("Amount"), Knob()]
          )
        )
      ).background_(Color.grey(0.9))
    );
  };
  
  view.layout = layout;
  view
};
