module par_chk (
    input wire par_chk_en,
    input wire sampled_bit,
    input wire done,
    input wire clk,
    input wire rst,
    input wire [3:0] bit_cnt, 
    input wire calculated_par,
    output reg par_error
);
always @(posedge clk , negedge rst) begin
    if (!rst)
    begin
        par_error<=0;
    end
    else if (par_chk_en && done && (calculated_par!=sampled_bit))
        par_error<=1;
        else if (bit_cnt==0) 
        par_error<=0;
    
    
    
end

    
endmodule
