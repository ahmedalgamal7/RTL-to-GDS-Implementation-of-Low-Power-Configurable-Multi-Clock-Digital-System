module RST_SYNC #(
    parameter NUM_STAGES=2
) (
    input wire RST,
    input wire CLK,
    output reg SYNC_RST
);
reg [NUM_STAGES-1:0] syn_reg ;
integer i;
    always @(posedge CLK or negedge RST) begin
        if (!RST)
        begin
    syn_reg <=0;
        end
        else 
        begin
            syn_reg<={syn_reg[NUM_STAGES-2:0],1'b1};
            
        end
    end


    always @(*) begin
        SYNC_RST =syn_reg[NUM_STAGES-1];
        
    end
endmodule