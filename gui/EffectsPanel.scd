// Effects Panel Component
~makeEffectsPanel = { |parent|
  var view, layout;
  
  view = View(parent)
    .background_(Color.grey(0.8));
    
  layout = VLayout().margins_(10).spacing_(5);
  
  // Delay Section
  layout.add(
    View().layout_(
      VLayout(
        StaticText().string_("DELAY").font_(Font("Helvetica", 12, true)).align_(\center),
        GridLayout.rows(
          [StaticText().string_("Time"), Knob().action_({ |k| /* Set delay time */ })],
          [StaticText().string_("Feedback"), Knob().action_({ |k| /* Set feedback */ })],
          [StaticText().string_("Mix"), Knob().action_({ |k| /* Set wet/dry mix */ })]
        ).margins_(5).spacing_(5)
      )
    ).background_(Color.grey(0.9))
  );
  
  // Reverb Section
  layout.add(
    View().layout_(
      VLayout(
        StaticText().string_("REVERB").font_(Font("Helvetica", 12, true)).align_(\center),
        GridLayout.rows(
          [StaticText().string_("Room Size"), Knob().action_({ |k| /* Set room size */ })],
          [StaticText().string_("Damping"), Knob().action_({ |k| /* Set damping */ })],
          [StaticText().string_("Mix"), Knob().action_({ |k| /* Set wet/dry mix */ })]
        ).margins_(5).spacing_(5)
      )
    ).background_(Color.grey(0.9))
  );
  
  view.layout = layout;
  view
};
