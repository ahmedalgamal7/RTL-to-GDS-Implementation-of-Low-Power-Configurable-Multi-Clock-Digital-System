module stop_chk (
    input wire stop_chk_en,
    input wire sampled_bit,
    input wire done,
    input wire clk,
    input wire [3:0] bit_cnt,
    input wire rst,
    output reg stop_error
);
always @(posedge clk , negedge rst) begin
    if (!rst)
    begin
        stop_error<=0;
    end
    else if (stop_chk_en && done && (sampled_bit!=1))
        stop_error<=1;
    else if (bit_cnt==0)
        stop_error<=0;
    
    
    
end

    
endmodule