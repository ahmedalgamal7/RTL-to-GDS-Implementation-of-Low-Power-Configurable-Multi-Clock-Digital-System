module fsm_rx (
    input wire [5:0] prescale,
    input wire clk,
    input wire rst,
    input wire par_en,
    input wire rx_in,
    input wire [5:0] edge_cnt,
    input wire [3:0] bit_cnt,
    input wire par_error,
    input wire strt_glitch,
    input wire stop_error,
    output reg par_chk_en,
    output reg strt_chk_en,
    output reg stop_chk_en,
    output reg data_valid,
    output reg deser_en,
    output reg data_sampled_en,
    output reg enable

);
localparam idle = 3'b0 ;
localparam start= 3'b1;
localparam data =3'b10 ;
localparam parity =3'b11 ;
localparam stop =3'b100 ;
localparam valid =3'b101 ;


reg [2:0] cs,ns;
always @(posedge clk or negedge rst) begin
    if (!rst) 
    cs<=idle;
    else 
    cs<=ns;
    
end
always @(*) begin
    case (cs)
        idle:begin
            if (rx_in==0)
            ns=start;
            else
            ns =idle;
            end 
        start: begin
            if (edge_cnt==7 && strt_glitch==0 && prescale==8)
            ns=data;
            else if (edge_cnt==7 && strt_glitch==1 && prescale==8)
            ns=idle;
            else if (edge_cnt==15 && strt_glitch==0 && prescale==16)
            ns=data;
            else if (edge_cnt==15 && strt_glitch==1 && prescale==16)
            ns=idle;
            else if (edge_cnt==31 && strt_glitch==0 && prescale==32)
            ns=data;
            else if (edge_cnt==31 && strt_glitch==1 && prescale==32)
            ns=idle;

            else 
            ns=start;
            end
        data:begin
             if (edge_cnt==7 && bit_cnt==8 && par_en==0 && prescale==8)
            ns=stop;
            else if ( edge_cnt==7 && bit_cnt==8 && par_en==1 && prescale==8)
            ns=parity;
            else if (edge_cnt==15 && bit_cnt==8 && par_en==0 && prescale==16)
            ns=stop;
            else if ( edge_cnt==15 && bit_cnt==8 && par_en==1 && prescale==16)
            ns=parity;
            else if (edge_cnt==31 && bit_cnt==8 && par_en==0 && prescale==32)
            ns=stop;
            else if ( edge_cnt==31 && bit_cnt==8 && par_en==1 && prescale==32)
            ns=parity;
            else 
            ns=data;  
            end   
        parity:   begin
         
             if (edge_cnt==7 && prescale==8)
            ns=stop;
            else if (edge_cnt==15 && prescale==16)
            ns=stop;
            else if (edge_cnt==31 && prescale==32)
            ns=stop;
            else 
            ns=parity;
            end  
        stop:    begin
             if (edge_cnt==6 && (stop_error||par_error) && prescale==8)          
            ns=idle;
            else if (edge_cnt==6 && (stop_error||par_error)==0 && prescale==8)      
            ns=valid;
            else if (edge_cnt==14 && (stop_error||par_error) && prescale==16)
            ns=idle;
            else if (edge_cnt==14 && (stop_error||par_error)==0 && prescale==16)
            ns=valid;
            else if (edge_cnt==30 && (stop_error||par_error) && prescale==32)
            ns=idle;
            else if (edge_cnt==30 && (stop_error||par_error)==0 && prescale==32)
            ns=valid;
            else 
            ns=stop;  
            end  
        valid:begin
        if (rx_in==0)
        ns =start;
        else 
        ns=idle;    
        end   
        default: ns =idle;
    endcase
end
always @(*) begin
    case (cs)
        idle:begin
     par_chk_en=0;
     strt_chk_en=0;
     stop_chk_en=0;
     data_valid=0;
     deser_en=0;
     data_sampled_en=0;
     enable=0;

        end
        start: begin
            strt_chk_en=1;
            data_sampled_en=1;
            enable=1;
            data_valid=0;
            par_chk_en=0;
            deser_en=0;
            stop_chk_en=0;

            
            end
        data:begin
            data_valid=0;
            strt_chk_en=0;
            data_sampled_en=1;
            enable=1;
            deser_en=1;
            par_chk_en=0;
            stop_chk_en=0;
            end   
        parity:   begin
            deser_en=0;
            par_chk_en=1;
            data_sampled_en=1;
            enable=1;
            stop_chk_en=0;
            data_valid=0;
            strt_chk_en=0;

            
            end  
        stop:    begin
            par_chk_en=0;
            stop_chk_en=1;
            deser_en=0;
            data_sampled_en=1;
            enable=1;
            data_valid=0;
            strt_chk_en=0;
             
            end  
        valid:   begin
     par_chk_en=0;
     strt_chk_en=0;
     stop_chk_en=0;
     data_valid=1;
     deser_en=0;
     data_sampled_en=0;
     enable=0;
        end
               
        default: begin
     par_chk_en=0;
     strt_chk_en=0;
     stop_chk_en=0;
     data_valid=0;
     deser_en=0;
     data_sampled_en=0;
     enable=0;

        end
    endcase
    
end
    
endmodule