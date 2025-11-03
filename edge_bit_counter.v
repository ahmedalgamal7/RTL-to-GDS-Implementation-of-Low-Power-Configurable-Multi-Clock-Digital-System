module edge_bit_counter (
    input wire enable,
    input wire clk,
    input wire par_en,
    input wire [5:0] prescale,
    input wire rst,
    output reg [3:0] bit_cnt,
    output reg [5:0] edge_cnt
);
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
        bit_cnt<=0;
        edge_cnt<=0;
        end
      else if (enable) 
      begin
        case (prescale)
           6'd8 : begin
            if (edge_cnt!=7)
            begin
                edge_cnt<=edge_cnt+1;
            end

            else if (edge_cnt==7 && par_en==1 && bit_cnt!=4'd10)
            begin
            bit_cnt<=bit_cnt +1;  
            edge_cnt<=0;
            end
            else if (edge_cnt==7 && par_en==0 && bit_cnt!=4'd9)begin
            bit_cnt<=bit_cnt +1;  
            edge_cnt<=0;
            end
           
            
            
           end 
           6'd16:begin
           if (edge_cnt!=15)
            begin
                edge_cnt<=edge_cnt+1;
            end
             else if (edge_cnt==15 && par_en==1 && bit_cnt!=4'd10)
            begin
            bit_cnt<=bit_cnt +1;  
            edge_cnt<=0;
            end
            else if (edge_cnt==15 && par_en==0 && bit_cnt!=4'd9)begin
            bit_cnt<=bit_cnt +1;  
            edge_cnt<=0;
            end
          
            
           end
             6'd32:begin
             if (edge_cnt!=31)
            begin
                edge_cnt<=edge_cnt+1;
            end
               else if (edge_cnt==31 && par_en==1 && bit_cnt!=4'd10)
            begin
            bit_cnt<=bit_cnt +1;  
            edge_cnt<=0;
            end
            else if (edge_cnt==31 && par_en==0 && bit_cnt!=4'd9)begin
            bit_cnt<=bit_cnt +1;  
            edge_cnt<=0;
            end
           
            
             end
            default:begin
             bit_cnt<=0;
             edge_cnt<=0;
            end
             
        endcase
      end

         else begin
                bit_cnt<=0;  
            edge_cnt<=0;
            end
        
      end
    
endmodule