// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

module tb_MorraCinese();

  	// File descriptors.
  	integer tbf, outf;
      
    // Inputs
    reg clk;
    reg INIZIO;
    reg [1:0] PRIMO;
    reg [1:0] SECONDO;

    // Outputs
    wire [1:0] MANCHE;
    wire [1:0] PARTITA;
    
    MorraCinese sem(
      	.clk(clk), 
        .INIZIO(INIZIO), 
        .PRIMO(PRIMO),
        .SECONDO(SECONDO),
        .MANCHE(MANCHE),
        .PARTITA(PARTITA)
    );
    
    always #10 clk = ~clk;
    
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      tbf = $fopen("testbench.script", "w");
      outf = $fopen("output_verilog.txt", "w");
      $fdisplay(tbf, "read_blif FSMD.blif");
      
      clk = 1'b0;
      //----------------------------------------------------------------------
      INIZIO = 1'b1;
      SECONDO = 2'b00;
      PRIMO = 2'b00;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b01;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b11;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b11;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b00;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b11;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b01;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b1;
      SECONDO = 2'b00;
      PRIMO = 2'b00;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b01;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b10;
      PRIMO = 2'b11;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b00;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b11;
      PRIMO = 2'b01;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b1;
      SECONDO = 2'b00;
      PRIMO = 2'b00;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b01;
      PRIMO = 2'b11;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b10;
      PRIMO = 2'b01;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b00;
      PRIMO = 2'b01;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b10;
      PRIMO = 2'b01;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b10;
      PRIMO = 2'b01;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b1;
      SECONDO = 2'b00;
      PRIMO = 2'b01;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b01;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b10;
      PRIMO = 2'b11;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b11;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b11;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b11;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b01;
      PRIMO = 2'b11;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b1;
      SECONDO = 2'b00;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b01;
      PRIMO = 2'b11;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b10;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //----------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b10;
      PRIMO = 2'b11;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //---------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b10;
      PRIMO = 2'b11;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //---------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b10;
      PRIMO = 2'b11;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //---------------------------------------------------------------------
      INIZIO = 1'b0;
      SECONDO = 2'b01;
      PRIMO = 2'b10;
      $fdisplay(tbf, "simulate %b %b %b %b %b", INIZIO, SECONDO[1], SECONDO[0], PRIMO[1], PRIMO[0]);
      #20
      $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
      //---------------------------------------------------------------------
      $fdisplay(tbf, "quit");
      $fclose(tbf);
      $fclose(outf);
      $finish;
    end
endmodule
