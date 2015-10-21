`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:22:16 07/31/2015 
// Design Name: 
// Module Name:    in50MHz_out1Hz 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module in50MHz_out1Hz(in_50MHz,out_1Hz);
input in_50MHz;
output out_1Hz;
reg out_1Hz;
reg [31:0]cnt; //use cnt to count
always@(posedge in_50MHz)
begin if(cnt < 32'd24999999)//计数到24999999

begin
cnt <= cnt + 1'B1;
end
else begin cnt <= 32'b0;
out_1Hz <= ~out_1Hz; //频率为1HZ
end
end
endmodule
