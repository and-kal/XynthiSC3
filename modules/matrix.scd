(
SynthDef(\matrix_router, {|i_in=32, i_out=0, amt=1|
  var sig = In.ar(i_in) * amt;
  Out.ar(i_out, sig);
}).send(s);

SynthDef(\matrix_router_mod, {|i_in=32, i_out=0, amt=1|
  var sig = In.kr(i_in) * amt;
  Out.kr(i_out, sig); 
}).send(s);

~audioMatrix = (
  reproduce: {|self|
    self.copy;
  },
  
  inputNames: nil,
  outputNames: nil,
  inputArr: nil,
  outputArr: nil,
  inputNodes: nil,
  nodeOrder: nil,
  synthArr: Array2D.new(17,17),
  modAmt: Array2D.new(17,17),
  
  makeMatrix: {|self, view|
    var gridView = View(view, view.bounds);
    var grid = GridLayout();
    var modKnobs = Array2D.new(17,17);
    
    // Header row
    grid.add(StaticText().string_(""), 0, 0);
    self.inputNames.do {|name, i|
      grid.add(StaticText().string_(name).align_(\center), 0, i+1); 
    };
    
    // Matrix rows
    self.outputNames.do {|name, row|
      grid.add(StaticText().string_(name).align_(\right), row+1, 0);
      
      self.inputArr.size.do {|col|
        var cell = View().layout_(
          VLayout(
            Button()
              .states_([[""],["X", Color.black, Color.gray]])
              .action_({|but|
                self.toggleConnection(row, col, but.value);
              }),
            Knob()
              .action_({|knob|
                self.setModAmount(row, col, knob.value);
              })
          )
        );
        grid.add(cell, row+1, col+1);
      };
    };
    
    gridView.layout = grid;
    gridView;
  },
  
  toggleConnection: {|self, row, col, state|
    var synthName;
    
    if(state == 1, {
      // Make connection
      if(self.nodeOrder.indexOf(self.outputArr[row]) < self.nodeOrder.indexOf(self.inputArr[col]), {
        synthName = \matrix_router;
      }, {
        synthName = \matrix_router_mod;
      });
      
      self.synthArr[row,col] = Synth(synthName, [
        \i_in, self.outputArr[row],
        \i_out, self.inputArr[col],
        \amt, self.modAmt[row,col] ? 1
      ]);
    }, {
      // Remove connection
      self.synthArr[row,col].free;
      self.synthArr[row,col] = nil;
    });
  },
  
  setModAmount: {|self, row, col, amt|
    self.modAmt[row,col] = amt;
    if(self.synthArr[row,col].notNil, {
      self.synthArr[row,col].set(\amt, amt);
    });
  }
);
)
