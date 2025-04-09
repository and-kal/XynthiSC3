// Preset Management Panel
~makePresetPanel = { |parent|
  var view, layout;
  
  view = View(parent).background_(Color.grey(0.8));
  layout = VLayout().margins_(10).spacing_(5);
  
  layout.add(StaticText().string_("PRESETS")
    .font_(Font("Helvetica", 12, true))
    .align_(\center));
    
  layout.add(
    HLayout(
      Button().states_([["Save"]]).action_({ /* Save preset */ }),
      Button().states_([["Load"]]).action_({ /* Load preset */ })
    )
  );
  
  layout.add(ListView()
    .items_(["Preset 1", "Preset 2", "Preset 3"])
    .action_({ |lv| /* Load selected preset */ })
  );
  
  layout.add(
    HLayout(
      Button().states_([["New"]]).action_({ /* Create new preset */ }),
      Button().states_([["Delete"]]).action_({ /* Delete selected preset */ })
    )
  );
  
  view.layout = layout;
  view
};
