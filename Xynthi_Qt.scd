(
Routine({
  var matrix;
  
  // Load modules
  "Loading Modules...".postln;
  "SynthEvents.scd".loadPaths;
  "modules/*.scd".loadPaths;
  "gui/*.scd".loadPaths;
  
  s.sync;
  
  // Initialize matrix
  matrix = ~audioMatrix.reproduce;
  
  // Create window
  ~mainWindow = Window("Xynthi", Rect(100, 100, 800, 600))
    .front;
    
  ~mainLayout = VLayout();
  
  // Add matrix panel
  ~matrixPanel = ~makeMatrixPanel(~mainWindow, matrix);
  ~mainLayout.add(~matrixPanel, stretch: 2);
  
  // Add mod panel
  ~modPanel = ~makeModPanel(~mainWindow, matrix); 
  ~mainLayout.add(~modPanel, stretch: 1);
  
  ~mainWindow.layout = ~mainLayout;
  ~mainWindow.front;
}).play;
)
