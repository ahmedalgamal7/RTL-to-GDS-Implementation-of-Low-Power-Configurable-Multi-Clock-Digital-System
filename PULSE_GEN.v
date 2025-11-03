module PULSE_GEN  (
    input wire lvl_sig,
    input wire clk,
    input wire rst,
    output reg pulse_sig
);
reg pulse;
always @(posedge clk or negedge rst) begin
    if (!rst)
    begin
        pulse<=0;
    end
    else 
    pulse<=lvl_sig;
end
always @(*) begin
    pulse_sig=lvl_sig & (!pulse);
end

    
endmodule