
/////////////////////////////////////////////////////////////
///////////////////// bit synchronizer //////////////////////
/////////////////////////////////////////////////////////////

module bit_sync # ( 
   parameter num_stages = 2 ,
	 parameter bus_width = 4 
)(
input    wire                      CLK,
input    wire                      RST,
input    wire    [bus_width-1:0]   ASYNC,
output   reg     [bus_width-1:0]   SYNC
);


reg   [num_stages-1:0] sync_reg [bus_width-1:0] ;

integer  I ;
					 
//----------------- Multi flop synchronizer --------------

always @(posedge CLK or negedge RST)
 begin
  if(!RST)      // active low
   begin
     for (I=0; I<bus_width; I=I+1)
      sync_reg[I] <= 'b0 ;
   end
  else
   begin
    for (I=0; I<bus_width; I=I+1)
     sync_reg[I] <= {sync_reg[I][num_stages-2:0],ASYNC[I]};   // {SYNC,sync_reg} <= {sync_reg[num_stages-1:0],ASYNC};
   end  
 end


always @(*)
 begin
  for (I=0; I<bus_width; I=I+1)
    SYNC[I] = sync_reg[I][num_stages-1] ; 
 end  

endmodule