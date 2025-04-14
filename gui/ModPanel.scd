// Modulation Panel
(
~makeModPanel = {|parent, matrix|
  var view = View(parent).background_(Color.grey(0.9));
  var layout = VLayout();
  
  layout.add(StaticText()
    .string_("MODULATION")
    .font_(Font.bold(14))
    .align_(\center)
  );
  
  // Add mod source selectors
  ["LFO1", "LFO2", "LFO3", "ENV1", "ENV2"].do {|src|
    var row = HLayout();
    row.add(StaticText().string_(src).align_(\right), stretch: 1);
    row.add(Knob().action_({|knob|
      // Set mod amount
    }), stretch: 2);
    layout.add(row);
  };
  
  view.layout = layout;
  view;
};
)
