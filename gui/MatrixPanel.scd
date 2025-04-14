// Matrix Panel Component
(
~makeMatrixPanel = { |parent, matrix|
  var view, layout, matrixView;
  var inputNames = ["VCO1", "VCO2", "VCO3", "NOISE", "IN1", "IN2", "RING", "ENV1", "ENV2", "LFO1", "LFO2", "LFO3", "FILT", "DEL", "VERB", "MIX1", "MIX2"];
  var outputNames = inputNames;
  
  view = View(parent, parent.bounds)
    .background_(Color.grey(0.85));
    
  layout = VLayout().margins_(2).spacing_(2);
  
  // Header
  layout.add(StaticText()
    .string_("ROUTING MATRIX")
    .font_(Font.bold(14))
    .align_(\center), 
    align: \top
  );

  // Matrix Grid Container  
  matrixView = View().background_(Color.white);
  matrix.inputNames = inputNames;
  matrix.outputNames = outputNames;
  matrix.inputArr = (0..16);
  matrix.outputArr = (32..48);
  matrix.nodeOrder = matrix.outputArr ++ matrix.inputArr;
  matrix.inputNodes = Array.fill(17, {nil});
  
  matrix.makeMatrix(matrixView);
  
  layout.add(matrixView, stretch: 1);
  view.layout = layout;
  
  view;
};
)
