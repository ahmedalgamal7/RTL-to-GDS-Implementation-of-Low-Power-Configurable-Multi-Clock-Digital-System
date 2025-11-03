module deserializer # ( parameter DATA_WIDTH = 8 ) (
    input wire clk,
    input wire rst,
    input wire sampled_bit,
    input wire done ,
    input wire deser_en,
    output reg [DATA_WIDTH-1:0] p_data
);
reg [3:0] counter;
reg [7:0] mem;
always @(posedge clk , negedge rst) begin
    if (!rst)
    begin
        p_data<=0;
        counter<=0;
        mem<=0;
    end
    else if (deser_en && done && counter!=8)
    begin
        mem[counter]<=sampled_bit;
        counter<=counter+1;
    end
       else if (counter==8) begin
        p_data<=mem;
        counter<=0;

        end
    
    end
    
    


endmodule