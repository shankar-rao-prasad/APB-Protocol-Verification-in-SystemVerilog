`include "trans.sv"
`include "gen.sv"
`include "driver.sv"
`include "monitor.sv"
`include "sco.sv"
`include "envi.sv"

module tb;
    
   abp_if vif();
 
   apb_s dut (
      .pclk    (vif.pclk),
      .presetn (vif.presetn),
      .paddr   (vif.paddr),
      .psel    (vif.psel),
      .penable (vif.penable),
      .pwdata  (vif.pwdata),
      .pwrite  (vif.pwrite),
      .prdata  (vif.prdata),
      .pready  (vif.pready),
      .pslverr (vif.pslverr)
   );
   
   initial vif.pclk = 0;
   always #10 vif.pclk = ~vif.pclk;
    
   environment env;
    
   initial begin
      env = new(vif);
      env.gen.count = 20;
      env.run();
   end
      
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
   
endmodule
