module  top_tb ();
reg                         RST_N_tb;
reg                         UART_CLK_tb;
reg                         REF_CLK_tb;
reg                         UART_RX_IN_tb;
wire                          UART_TX_O_tb;
wire                          parity_error_tb;
wire                          framing_error_tb;
always #135.6 UART_CLK_tb=~UART_CLK_tb;
always #10 REF_CLK_tb=~REF_CLK_tb;
parameter UART_CLK_=8678.4;
parameter REF_CLK_=20;
SYS_TOP U0_SYS_TOP (
.RST_N(RST_N_tb),
.UART_CLK(UART_CLK_tb),
.REF_CLK(REF_CLK_tb),
.UART_RX_IN(UART_RX_IN_tb),
.UART_TX_O(UART_TX_O_tb),
.parity_error(parity_error_tb),
.framing_error(framing_error_tb)
);

initial begin

        initialize();
    
        reset();

        @ (negedge UART_CLK_tb);
        // sending aa to write in regfile
        frame(0,0,1,0,1,0,1,0,1,0,1); //aa
      
       
         //sending the address "5"
          @ (negedge UART_CLK_tb);
          frame(0,1,0,1,0,0,0,0,0,0,1); //5
          $display("here we should write aa in 5 reg file and the time is ",$time);
     
        
          @ (negedge UART_CLK_tb);
          // sending data to write "5f"
          frame(0,1,1,1,1,1,0,1,0,0,1);
     
         $display("here we should write 5f in 5 reg file and the time is ",$time);
           
           //sending aa to write
          @ (negedge UART_CLK_tb);
           frame(0,0,1,0,1,0,1,0,1,0,1); //aa
        
       
           @ (negedge UART_CLK_tb);
            // sending the address "7"
            frame (0,1,1,1,0,0,0,0,0,1,1);
     
         
         @ (negedge UART_CLK_tb);
         // sending data "b1" to write in regfile
         frame(0,1,0,0,0,1,1,0,1,0,1);
        
         $display("here we should write b1 in 7 reg file and the time is ",$time);
         
            //sending aa to write
      
          @ (negedge UART_CLK_tb);
           frame(0,0,1,0,1,0,1,0,1,0,1); //aa
       
         
            //sending aa to be addr
          @ (negedge UART_CLK_tb);
           frame(0,0,1,0,1,0,1,0,1,0,1); //aa
        
         
           //sending e3 to write
          @ (negedge UART_CLK_tb);
          frame (0,1,1,0,0,0,1,1,1,1,1);
      
         $display("here we should write e3 in 10 reg file and the time is ",$time);
          //sending bb to read
         
          @ (negedge UART_CLK_tb);
          frame(0,1,1,0,1,1,1,0,1,0,1);
       
          //sending the address "5"
          @ (negedge UART_CLK_tb);
          frame(0,1,0,1,0,0,0,0,0,0,1);
      
         $display("here we should read 5f in 5 reg file and the time is ",$time);
          
          /////////////////sending bb to read
          @ (negedge UART_CLK_tb);
          frame(0,1,1,0,1,1,1,0,1,0,1);
         
              // sending the address "7"
        @ (negedge UART_CLK_tb);
        frame (0,1,1,1,0,0,0,0,0,1,1);
      
         $display("here we should read b1 in 5 reg file and the time is ",$time);
           #200;
          /////////////////sending cc to read
          @ (negedge UART_CLK_tb);
          frame(0,0,0,1,1,0,0,1,1,0,1);
        
         
          ////////////////////////sending 2b as a operand

            @ (negedge UART_CLK_tb);
            frame (0,1,1,0,1,0,1,0,0,0,1);
        
         
         ////////////////////////////sending f as operand b 
           @ (negedge UART_CLK_tb);
          frame (0,1,1,1,1,0,0,0,0,0,1);

         

         //multiplication
          @ (negedge UART_CLK_tb);
          frame (0,0,1,0,0,0,0,0,0,1,1);
       
         #200;
         $display("here we should multiply 2b*f i=285 and the time is ",$time);

            /////////////////dd
          @ (negedge UART_CLK_tb);
          frame (0,1,0,1,1,1,0,1,1,0,1);
        
         #200;
        /////////////////add
         @ (negedge UART_CLK_tb);
         frame (0,0,0,0,0,0,0,0,0,0,1);
         #200;
         $display("here we should add 2b+f=3a and the time is ",$time);
        
         #UART_CLK_;
         #UART_CLK_;
         #UART_CLK_;
         #UART_CLK_;
         #UART_CLK_;
         #UART_CLK_;
         #200000;
      
            $stop;
end


    /////////////// Signals Initialization //////////////////

task initialize ;
  begin
      	RST_N_tb=1;
        UART_CLK_tb=0;
        REF_CLK_tb=0;
        UART_RX_IN_tb=1;
  end
endtask

task reset ;
  begin
         @ (negedge UART_CLK_tb);
         RST_N_tb=0;
         @ (negedge UART_CLK_tb);
          RST_N_tb=1;

 end
endtask

  task frame;
    input start;
    input first;
    input second;
    input third;
    input fourth;
    input fifth;
    input sixth;
    input seventh;
    input eighth;
    input parity;
    input last;
    begin
        UART_RX_IN_tb=start;
        #UART_CLK_;
        UART_RX_IN_tb=first;
         #UART_CLK_;
         UART_RX_IN_tb=second;
         #UART_CLK_;
         UART_RX_IN_tb=third;
         #UART_CLK_;
         UART_RX_IN_tb=fourth;
         #UART_CLK_;
         UART_RX_IN_tb=fifth;
         #UART_CLK_;
         UART_RX_IN_tb=sixth;
         #UART_CLK_;
         UART_RX_IN_tb=seventh;
         #UART_CLK_;
         UART_RX_IN_tb=eighth;
         #UART_CLK_;
         UART_RX_IN_tb=parity;
         #UART_CLK_;
         UART_RX_IN_tb=last;
         #UART_CLK_;
         #200 ;
    end
  endtask    
endmodule