//BY: Cosmo  QQ：385988913
`timescale 1ns / 1ps
`include "pcileech_header.svh"


module pcileech_bar_impl_BCM(
    input               rst,
    input               clk,
    // incoming BAR writes:
    input [31:0]        wr_addr,
    input [3:0]         wr_be,
    input [31:0]        wr_data,
    input               wr_valid,
    // incoming BAR reads:
    input  [87:0]       rd_req_ctx,
    input  [31:0]       rd_req_addr,
    input               rd_req_valid,
    input [31:0]        base_address_register,
	
    // outgoing BAR read replies:
    output reg [87:0]   rd_rsp_ctx,
    output reg [31:0]   rd_rsp_data,
    output reg          rd_rsp_valid
);

	
    reg [87:0]      drd_req_ctx;
    reg [31:0]      drd_req_addr;
    reg             drd_req_valid;

    reg [31:0]      dwr_addr;
    reg [31:0]      dwr_data;
    reg             dwr_valid;

    reg [31:0]      data_0068;
    reg [31:0]      data_6800;
    reg [31:0]      data_0074;
    reg [31:0]      data_7020;
    reg [31:0]      data_5004;
    reg [31:0]      data_6804;
    reg [31:0]      data_4c00;
    reg [31:0]      data_6808;
    reg [31:0]      data_7024;
    reg [31:0]      data_7000;
    reg [31:0]      data_700c;
    reg [31:0]      data_7010;
    reg [31:0]      data_044c; 
    reg [1:0]       state_044c;
    reg             state_2838;
    reg [31:0]      data_0070;
    reg [31:0]      data_0204;
    reg [31:0]      data_0400;
    reg [31:0]      data_3c00;
    reg [31:0]      data_0408;
    reg [31:0]      data_0470;
    reg [31:0]      data_0478;   
    reg [31:0]      data_047c;
    reg [31:0]      data_0480;
    reg [31:0]      data_0484;
    reg [31:0]      data_0488;
    reg [31:0]      data_048c;
    reg [31:0]      counter_2838;


    always @ (posedge clk) begin
        if (rst)begin
            data_5004 <= 32'h80008000;
            data_6804 <= 32'h3c0850fe;
            data_4c00 <= 32'h0;
            data_6808 <= 32'h4f01;
            data_7024 <= 32'h0;
            data_7000 <= 32'h188;
            state_044c <= 2'b00;
            state_2838 <= 1'b0;
            data_0070 <= 32'h1292;
            counter_2838 <= 0;      

        end else begin
        drd_req_ctx     <= rd_req_ctx;
        drd_req_valid   <= rd_req_valid;
        dwr_valid       <= wr_valid;
        drd_req_addr    <= (rd_req_addr & 32'hFFFF);
        rd_rsp_ctx      <= drd_req_ctx;
        rd_rsp_valid    <= drd_req_valid;
        dwr_addr        <= (wr_addr & 32'hFFFF);
        dwr_data        <= wr_data;

		if (drd_req_valid) begin
            case (drd_req_addr)
                16'h0068: rd_rsp_data <= data_0068;
                16'h6800: rd_rsp_data <= data_6800;
                16'h4000 : rd_rsp_data <= 32'h2;
                16'h0074 : rd_rsp_data <= data_0074;
                16'h7020 : rd_rsp_data <= data_7020;
                16'h5004 : begin
                    rd_rsp_data <= data_5004;
                    if(data_5004 == 32'h80008000) data_5004 <= 32'h400;
                end
                16'h5000 : rd_rsp_data <= 32'h400;
                16'h6804 : rd_rsp_data <= data_6804;
                16'h4c00 : rd_rsp_data <= data_4c00;
                16'h6838 : rd_rsp_data <= 32'h3c0000;
                16'h6808 : rd_rsp_data <= data_6808;
                16'h7014 : rd_rsp_data <= 32'h2008273;
                16'h7024 : rd_rsp_data <= data_7024;
                16'h7000 : begin
                    rd_rsp_data <= data_7000;
                    if(data_7000 == 32'h190) data_7000 <= 32'h188;
                end    
                16'h700c : rd_rsp_data <= data_700c;
                16'h7010 : rd_rsp_data <= data_7010;
                16'h0454 : rd_rsp_data <= 32'hc0000;
                16'h044c : begin
                    rd_rsp_data <= data_044c;
                    if((data_044c[31:16] == 16'h2820) && state_044c == 2'b00) begin
                        data_044c <= {4'h0, data_044c[27:16],4'h1,data_044c[11:0]};
                    end  else data_044c <= {4'h0, data_044c[27:16],8'h31,data_044c[7:0]};
                    if(data_044c[31:16] == 16'h2838 && state_2838 ==1'b1) begin
                        data_044c <= 32'h8387477;
                    end else data_044c <= 32'h8380400;
                    if(data_044c == 32'h28210000) data_044c <= 32'h8217949;
                    if(data_044c == 32'h28220000) data_044c <= 32'h8220020;
                    if(data_044c == 32'h28240000) data_044c <= 32'h8240de1;
                    if(data_044c == 32'h28290000) data_044c <= 32'h8290300;	
		    if (data_044c[23:16] == 8'h25 || data_044c[23:16] == 8'h30 || data_044c[23:16] == 8'h31 || data_044c[27:24] == 4'h4）begin
			data_044c <= {4'h0,data_044c[27:0]};
	            end	
                end

                16'h0070 : begin
                    rd_rsp_data <= data_0070;
                    if(data_0070 == 32'h1292) data_0070 <= 32'h1092;
                end
                16'h0204 : rd_rsp_data <= data_0204;
                16'h7e2c : rd_rsp_data <= 32'h300;
                16'h00c4 : rd_rsp_data <= 32'h8000;
                16'h8b50 : rd_rsp_data <= 32'h4b657654;
                16'h0400 : rd_rsp_data <= data_0400;
                16'h006c : rd_rsp_data <= 32'h761b0000;
                16'h4414 : rd_rsp_data <= 32'h10;
                16'h4418 : rd_rsp_data <= 32'h60;
                16'h4400 : rd_rsp_data <= 32'h6;
                16'h2450 : rd_rsp_data <= 32'h1;
                16'h2454 : rd_rsp_data <= 32'h78fba880;
                16'h2458 : rd_rsp_data <= 32'h2000000;
                16'h245c : rd_rsp_data <= 32'h6000;
                16'h2c18 : rd_rsp_data <= 32'h8;
                16'h0410 : rd_rsp_data <= 32'h10;
                16'h0414 : rd_rsp_data <= 32'h184e8be7;
                16'h0418 : rd_rsp_data <= 32'h10;
                16'h041c : rd_rsp_data <= 32'h184e8be7;
                16'h0420 : rd_rsp_data <= 32'h10;
                16'h0424 : rd_rsp_data <= 32'h184e8be7;
                16'h0428 : rd_rsp_data <= 32'h10;
                16'h042c : rd_rsp_data <= 32'h184e8be7;
                16'h0438 : rd_rsp_data <= 32'h21a;
                16'h043c : rd_rsp_data <= 32'h5f2;
                16'h0464 : rd_rsp_data <= 32'h2620;
                16'h0500 : rd_rsp_data <= 32'h8;
                16'h2010 : rd_rsp_data <= 32'h181;
                16'h2018 : rd_rsp_data <= 32'h790807;
                16'h2014 : rd_rsp_data <= 32'h1;
                16'h0c0c : rd_rsp_data <= 32'h1;
                16'h0c08 : rd_rsp_data <= 32'h3;
                16'h3c00 : rd_rsp_data <= data_3c00;
                16'h3c08 : rd_rsp_data <= 32'ha;
                16'h3c0c : rd_rsp_data <= 32'h1e;
                16'h3c10 : rd_rsp_data <= 32'h5;
                16'h3c14 : rd_rsp_data <= 32'hc8;
                16'h3c20 : rd_rsp_data <= 32'h1;
                16'h3c24 : rd_rsp_data <= 32'h23;
                16'h3c38 : rd_rsp_data <= 32'h1;
                16'h3c3c : rd_rsp_data <= 32'h78fba000;
                16'h3000 : rd_rsp_data <= 32'h6;
                16'h2000 : rd_rsp_data <= 32'h2;
                16'h4800 : rd_rsp_data <= 32'h80303fe;
                16'h2800 : rd_rsp_data <= 32'h6;
                16'h1000 : rd_rsp_data <= 32'h2;
                16'h1c00 : rd_rsp_data <= 32'h6;
                16'h2c00 : rd_rsp_data <= 32'h6;
                16'h2400 : rd_rsp_data <= 32'h12;
                16'h0c00 : rd_rsp_data <= 32'ha;
                16'h1800 : rd_rsp_data <= 32'h16;
                16'h1400 : rd_rsp_data <= 32'h6;
                16'h045c : rd_rsp_data <= 32'h2;
                16'h0468 : rd_rsp_data <= 32'h2;
                16'h040c : rd_rsp_data <= 32'h800;
                16'h0450 : rd_rsp_data <= 32'h1;
                16'h0408 : rd_rsp_data <= data_0408;
                16'h0404 : rd_rsp_data <= 32'h400000;
                16'h0470 : rd_rsp_data <= data_0470;
                16'h0478 : rd_rsp_data <= data_0478;
                16'h047c : rd_rsp_data <= data_047c;
                16'h0480 : rd_rsp_data <= data_0480;
                16'h0484 : rd_rsp_data <= data_0484;
                16'h0488 : rd_rsp_data <= data_0488;
                16'h048c : rd_rsp_data <= data_048c;        
            default: rd_rsp_data <= 32'h00000000;
			endcase
                
        end else if (dwr_valid) begin
            case (dwr_addr) 
                16'h0068: begin
                    case (dwr_data)
                        32'h298 : begin
                            data_6808 <= 32'h1004f09; 
                            data_0068 <= dwr_data + 32'h42010000;
                        end
                        default: data_0068 <= dwr_data + 32'h42010000;
                    endcase
                end    
                16'h6804 : begin
                    case (dwr_data)
                        32'h3c0850fe : data_0068 <= 32'h4201029a;
                        32'h4000082 : data_6804 <= 32'h1c084082;
                    endcase
                end
                16'h6800: data_6800 <= dwr_data;
                16'h0074 : begin
                    case (dwr_data)
                        32'h6000000 :  data_0074 <= 32'h60000a0;
                        32'h60000a0 :  data_0074 <= 32'h6000080;
                    endcase
                end
                16'h7020 : begin
                    case (dwr_data)
                        32'h2 : data_7020 <= 32'h2200;
                        32'h20 : data_7020 <= 32'h0; 
                    endcase
                end
                16'h4c00 : data_4c00 <= dwr_data;
                16'h6808 : begin
                    case (dwr_data)
                        32'h1000008 : data_6808 <= 32'h1000709;
                        default: data_6808 <= dwr_data;
                    endcase
                end
                16'h0400 : begin
                    case (dwr_data)
                        32'h400 : data_6808 <= 32'h701; 
                    endcase
                end
                16'h7024 : data_7024 <= dwr_data;
                16'h7000 : data_7000 <= 32'h190;
                16'h700c : begin
                    case (dwr_data)
                        32'h7c : begin 
							data_700c <= 32'h7c; 
							data_7010 <= 32'h10;
						end
                        32'h80 : begin 
							data_700c <= 32'h80; 
							data_7010 <= 32'h184e8be7;
						end
                        32'h0  : begin data_700c <= 32'h0;  data_7010 <= 32'h669955aa;end
                    endcase
                end
                16'h044c : begin
                    data_044c <= dwr_data;
                    if(dwr_data == 32'h24208040) state_044c <= 2'b01;
                    if(dwr_data == 32'h24201200) state_044c <= 2'b00;
                    if(dwr_data == 32'h28380000) begin
                        counter_2838 <= counter_2838 + 1;
                        if(counter_2838 == 1) begin 
                            state_2838 <= 1'b1;
                        end else state_2838 <= 1'b0;    
                    end
                end
                16'h0204 : data_0204 <= dwr_data;
                16'h0400 : data_0400 <= dwr_data;
                16'h3c00 : begin
                    case (dwr_data)
                        32'h502 : data_3c00 <= 32'h102; 
                        default: data_3c00 <= dwr_data;
                    endcase
                end    
                16'h0408 : data_0408 <= dwr_data;
                16'h0470 : data_0470 <= dwr_data;
                16'h0478 : data_0478 <= dwr_data;
                16'h047c : data_047c <= dwr_data;
                16'h0480 : data_0480 <= dwr_data;
                16'h0484 : data_0484 <= dwr_data;
                16'h0488 : data_0488 <= dwr_data;
                16'h048c : data_048c <= dwr_data;     
            endcase
			end
		end
	end
endmodule
