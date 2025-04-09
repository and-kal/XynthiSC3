// Matrix Panel Component
~makeMatrixPanel = { |parent|
  var view, layout, matrixSize = 8;
  
  view = View(parent).background_(Color.grey(0.8));
  layout = VLayout().margins_(10).spacing_(5);
  
  layout.add(StaticText().string_("ROUTING MATRIX")
    .font_(Font("Helvetica", 12, true))
    .align_(\center));
    
  // Create matrix grid
  var gridLayout = GridLayout();
  matrixSize.do { |row|
    matrixSize.do { |col|
      var button = Button()
        .states_([
          ["·", Color.black, Color.white],
          ["×", Color.white, Color.blue]
        ])
        .action_({ |btn|
          // Handle matrix routing
        });
      gridLayout.add(button, row, col);
    };
  };
  
  layout.add(gridLayout);
  view.layout = layout;
  view
};
