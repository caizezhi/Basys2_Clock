`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:26:42 07/31/2015 
// Design Name: 
// Module Name:    counter3 
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
module counter3(en,ncr,clk,q);
input en,ncr,clk;
output [3:0] q;
reg [3:0] q;
always@(posedge clk)
begin
if(ncr) q<=4'b0000;//NCR=0，同步清零
else if(en==0) q<=q;//EN=0，暂停计数
else if(q==4'd2) q<=4'b0000;
else q<=q+1'b1;//计数器增1
end
endmodule
