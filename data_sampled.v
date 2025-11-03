module data_sampled (
    input wire data_sampled_en,
    input wire rx_in,
    input wire [5:0] prescale,
    input wire [5:0] edge_cnt,
    input wire clk,
    input wire rst,
    output reg sampled_bit,
    output reg done
    
);
reg sample1;
reg sample2;
reg sample3;


always @(posedge clk or negedge rst) begin
    if (!rst)
    begin
        sample1<=0;
        sample2<=0;
        sample3<=0;
        done<=0;
    end
   else begin
    case (prescale)
       6'd8 : begin
        if (data_sampled_en && edge_cnt==2 )
   begin
    sample1<=rx_in;
   end
    else if (data_sampled_en && edge_cnt==3 )
   begin
    sample2<=rx_in;
   end
    else if (data_sampled_en && edge_cnt==4 )
   begin
    sample3<=rx_in;
    done<=1;
   end
   else if (data_sampled_en && edge_cnt==5 )
   begin
    done<=0;
   end 
       end
       6'd16: begin
     if (data_sampled_en && prescale ==16 && edge_cnt==6 )
   begin
    sample1<=rx_in;
   end
    else if (data_sampled_en && prescale ==16 && edge_cnt==7 )
   begin
    sample2<=rx_in;
   end
    else if (data_sampled_en && prescale ==16 && edge_cnt==8 )
   begin
    sample3<=rx_in;
    done<=1;
   end
     else if (data_sampled_en && prescale ==16 && edge_cnt==9 )
   begin
    done<=0;
   end
        
       end
       6'd32: begin
    if (data_sampled_en && prescale ==32 && edge_cnt==14 )
   begin
    sample1<=rx_in;
   end
    else if (data_sampled_en && prescale ==32 && edge_cnt==15 )
   begin
    sample2<=rx_in;
   end
    else if (data_sampled_en && prescale ==32 && edge_cnt==16 )
   begin
    sample3<=rx_in;
    done<=1;
   end
     else if (data_sampled_en && prescale ==32 && edge_cnt==17 )
   begin
    done<=0;
   end  
       end
    endcase
       end
 

end

    always @(*) begin
    
     if (done)
    begin
        if (sample1==sample2) begin
        sampled_bit= sample1;
        end
        else if (sample1==sample3)
        begin
        sampled_bit=sample1;
         end
        else if(sample2==sample3) 
        begin
        sampled_bit = sample2;
        end
        else 
        sampled_bit=0;

    end
    else 
        sampled_bit=0;

    
    
end

    
endmodule