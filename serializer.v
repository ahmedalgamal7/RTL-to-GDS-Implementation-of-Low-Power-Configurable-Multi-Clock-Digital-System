/*module serializer (
    input wire clk,
    input wire rst,
    input wire ser_en,
    input wire [7:0] p_data,
    output wire ser_done,
    output reg ser_data,
    output reg [7:0] memory                                 //added output signal
    );
reg [3:0] counter;
reg [7:0] mem;
assign ser_done=(counter==4'b1000)?1'b1:1'b0;
always @(posedge clk or negedge rst) begin
    if (~rst)
    begin
        mem<=8'b0;
        ser_data<=1'b1;
        counter<=4'b0;

    end
    else if(ser_en==1 && counter ==0 )
    begin
        mem<=p_data;
        counter<=counter+1;   
        ser_data<=p_data[0];     
    end
    else if (ser_en==1 && counter != 4'b0 && counter <=4'b1000)
    begin
        if (counter==4'b1000)
        counter<=0;
        else begin
        counter<=counter+1;
        ser_data<=mem[counter];
        memory<=mem;
    end
    end
    
end
    
endmodule*/
module serializer (
    input wire clk,
    input wire rst,
    input wire ser_en,
    input wire [7:0] p_data,
    input wire data_valid,
    input wire busy ,
    output wire ser_done,
    output reg ser_data,
    output reg [7:0] memory 
    );
reg [3:0] counter;
reg [7:0] mem;
assign ser_done=(counter==4'b1000)?1'b1:1'b0;
always @(posedge clk or negedge rst) begin
    if (~rst)
    begin
        mem<=8'b0;
        ser_data<=1'b1;
        counter<=4'b0;

    end
    else if(data_valid && !busy )
    begin
        mem<=p_data;   
    end
    else if (ser_en==1)
    begin
       if (counter==4'b1000)
        counter<=0;
        else begin
        counter<=counter+1;
        ser_data<=mem[counter];
        memory<= mem;
        end
        end
    
end



endmodule