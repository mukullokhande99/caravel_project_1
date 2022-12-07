`timescale 1ns / 1ps

module fp_alu(
    input [31:0] add_a,
    input [31:0] add_b,
    input clk,
    input reset,
      
    output [31:0] sum
    );

 
reg [24:0] temp_mantissa;
reg [7:0] temp_exp [3:1];

reg [7:0] exp;
reg [22:0] mantissa;
reg sign [4:1];

reg [23:0] mantissa_a [2:0];
reg [23:0] mantissa_b [2:0];
reg [7:0] exp_a;
reg [7:0] exp_b;
reg sign_a;
reg sign_b;

reg [7:0] exp_diff [2:1];
reg agtb [2:1];

reg operation [2:0];

assign sum = {sign[4],exp,mantissa};

assign a_zero = ~(| add_a);
assign b_zero = ~(| add_b);

wire [30:0] a_eq_b;
assign a_eq_b = (add_a[30:0]^add_b[30:0]);

reg zero [3:0];

    
always @(posedge clk) begin
   
    if (reset == 1'b1) begin
        temp_mantissa <= 25'd0;
        temp_exp[1] <= 8'd0;
        temp_exp[2] <= 8'd0;
        temp_exp[3] <= 8'd0;
        exp <= 8'd0;
        mantissa <= 23'd0;
        sign[1] <= 1'd0;
        sign[2] <= 1'd0;
        sign[3] <= 1'd0;
        sign[4] <= 1'd0;
        mantissa_a[0] <= 24'd0;
        mantissa_b[0] <= 24'd0;
        mantissa_a[1] <= 24'd0;
        mantissa_b[1] <= 24'd0;
        mantissa_a[2] <= 24'd0;
        mantissa_b[2] <= 24'd0;
        exp_diff[1] <= 8'd0;
        exp_diff[2] <= 8'd0;
        agtb[1] <= 1'd0;
        agtb[2] <= 1'b0;
        operation[0] <= 1'b0;
        operation[1] <= 1'b0;
        operation[2] <= 1'b0;
        end
    
    else begin
        ////////////////////////////////////////////////
        
        if (zero[3] == 1'b0) begin
        casex(temp_mantissa)
            
            25'b1xxxxxxxxxxxxxxxxxxxxxxxx : begin
                exp <= temp_exp[3] + 8'd1;
                mantissa <= temp_mantissa[23:1];
                end
            
            25'b01xxxxxxxxxxxxxxxxxxxxxxx : begin
                exp <= temp_exp[3];
                mantissa <= temp_mantissa[22:0];
                end
            
            25'b001xxxxxxxxxxxxxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd1;
                mantissa <= {temp_mantissa[21:0],1'd0};
                end
            
            25'b0001xxxxxxxxxxxxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd2;
                mantissa <= {temp_mantissa[20:0],2'd0};
                end
            
            25'b00001xxxxxxxxxxxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd3;
                mantissa <= {temp_mantissa[19:0],3'd0};
                end
            
            25'b000001xxxxxxxxxxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd4;
                mantissa <= {temp_mantissa[18:0],4'd0};
                end
            
            25'b0000001xxxxxxxxxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd5;
                mantissa <= {temp_mantissa[17:0],5'd0};
                end
            
            25'b00000001xxxxxxxxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd6;
					 mantissa <= {temp_mantissa[16:0],6'd0};
                end
            
            25'b000000001xxxxxxxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd7;
                mantissa <= {temp_mantissa[15:0],7'd0};
                end
            
            25'b0000000001xxxxxxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd8;
                mantissa <= {temp_mantissa[14:0],8'd0};
                end
            
            25'b00000000001xxxxxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd9;
                mantissa <= {temp_mantissa[13:0],9'd0};
                end
            
            25'b000000000001xxxxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd10;
                mantissa <= {temp_mantissa[12:0],10'd0};
                end
            
            25'b0000000000001xxxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd11;
                mantissa <= {temp_mantissa[11:0],11'd0};
                end
            
            25'b00000000000001xxxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd12;
                mantissa <= {temp_mantissa[10:0],12'd0};
                end
            
            25'b000000000000001xxxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd13;
                mantissa <= {temp_mantissa[9:0],13'd0};
                end
            
            25'b0000000000000001xxxxxxxxx : begin
                exp <= temp_exp[3] - 8'd14;
                mantissa <= {temp_mantissa[8:0],14'd0};
                end
            
            25'b00000000000000001xxxxxxxx : begin
                exp <= temp_exp[3] - 8'd15;
                mantissa <= {temp_mantissa[7:0],15'd0};
                end
            
            25'b000000000000000001xxxxxxx : begin
                exp <= temp_exp[3] - 8'd16;
                mantissa <= {temp_mantissa[6:0],16'd0};
                end
            
            25'b0000000000000000001xxxxxx : begin
                exp <= temp_exp[3] - 8'd17;
                mantissa <= {temp_mantissa[5:0],17'd0};
                end
            
            25'b00000000000000000001xxxxx : begin
                exp <= temp_exp[3] - 8'd18;
                mantissa <= {temp_mantissa[4:0],18'd0};
                end
            
            25'b000000000000000000001xxxx : begin
                exp <= temp_exp[3] - 8'd19;
                mantissa <= {temp_mantissa[3:0],19'd0};
                end
            
            25'b0000000000000000000001xxx : begin
                exp <= temp_exp[3] - 8'd20;
                mantissa <= {temp_mantissa[2:0],20'd0};
                end
            
            25'b00000000000000000000001xx : begin
                exp <= temp_exp[3] - 8'd21;
                mantissa <= {temp_mantissa[1:0],21'd0};
                end
            
            25'b000000000000000000000001x : begin
                exp <= temp_exp[3] - 8'd22;
                mantissa <= {temp_mantissa[0],22'd0};
                end
            
            25'b0000000000000000000000001 : begin
                exp <= temp_exp[3] - 8'd23;
                mantissa <= 23'd0;
                end
            
            default : begin
                exp <= 8'd0;
                mantissa <= 23'd0;
                end
            
            endcase
            sign[4] <= sign[3];
            end
        else begin
            sign[4] <= 1'b0;
            exp <= 8'd0;
            mantissa <= 23'd0;
            end
        //////////////////////////////////////////////
        if (operation[2] == 1'b1) begin
            
            if (agtb[2] == 1'b1) begin
                temp_mantissa <= (mantissa_a[2] - mantissa_b[2]);
                end
            else begin
                temp_mantissa <= (mantissa_b[2] - mantissa_a[2]);
                end
            end
        
        else begin
            temp_mantissa <= (mantissa_a[2] + mantissa_b[2]);
            end
        //operation[3] <= operation[2];
        temp_exp[3] <= temp_exp[2];
        sign[3] <= sign[2];
        zero[3] <= zero[2];
        //////////////////////////////////////////////
        if (exp_diff[1] == 1'b0) begin
            mantissa_a[2] <= mantissa_a[1];
            mantissa_b[2] <= mantissa_b[1];
            end
        else begin
            
            if (agtb[1] == 1'b1) begin
                mantissa_a[2] <= mantissa_a[1];
                mantissa_b[2] <= (mantissa_b[1] >> exp_diff[1]);
                end
            else begin
                mantissa_a[2] <= (mantissa_a[1] >> exp_diff[1]);
                mantissa_b[2] <= mantissa_b[1];
                end
            end
        operation[2] <= operation[1];
        agtb[2] <= agtb[1];
        temp_exp[2] <= temp_exp[1];
        sign[2] <= sign[1];
        zero[2] <= zero[1];
        ////////////////////////////////////////////////
        if (exp_a > exp_b) begin
            agtb[1]     <= 1'b1;
            exp_diff[1] <= (exp_a - exp_b);
            sign[1]     <= sign_a;
            temp_exp[1] <= exp_a;
            end
        else if (exp_a < exp_b) begin
            agtb[1]     <= 1'b0;
            exp_diff[1] <= (exp_b - exp_a);
            sign[1]     <= sign_b;
            temp_exp[1] <= exp_b;
            end
        else begin
            if (mantissa_a[0] > mantissa_b[0]) begin
                agtb[1]     <= 1'b1;
                exp_diff[1] <= (exp_b - exp_a);
                sign[1]     <= sign_a;
                temp_exp[1] <= exp_a;
                end
            else begin
                exp_diff[1] <= (exp_b - exp_a);
                agtb[1]     <= 1'b0;
                sign[1]     <= sign_b;
                temp_exp[1] <= exp_a;
                end
            end
        operation[1] <= operation[0];
        mantissa_a[1] <= mantissa_a[0];
        mantissa_b[1] <= mantissa_b[0];
        zero[1] <= zero[0];
        //////////////////////////////////////////////////
        operation[0] <= add_a[31]^add_b[31];
        
        exp_a <= add_a[30:23];
        exp_b <= add_b[30:23];
        sign_a <= add_a[31];
        sign_b <= add_b[31];
        mantissa_a[0] <= {1'b1,add_a[22:0]};
        mantissa_b[0] <= {1'b1,add_b[22:0]};
        
        if ((add_a[31]^add_b[31]) == 1'b0) begin
            if ((a_zero == 1'b1) && (b_zero == 1'b1)) begin
                zero[0] <= 1'b1;
                end
            else begin
                zero[0] <= 1'b0;
                end
            end
        
        else begin
            if (a_eq_b == 32'd0) begin
                zero[0] <= 1'b1;
                end
            else begin
                zero[0] <= 1'b0;
                end
            end
        //////////////////////////////////////////////////
        end
     end

endmodule
