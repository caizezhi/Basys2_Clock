`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:55:18 07/31/2015 
// Design Name: 
// Module Name:    bell 
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
module bell(switch,set,crl,p,clk,cnt,cnt1,led
); //ÄÖÖÓÄ£¿é
input switch,set,crl,clk;
input [23:0] cnt;
input [3:0] p;
output [23:0] cnt1;
output [1:0] led;
reg led;
reg cl;
adjust f(clk,set,switch,p,cnt1);
always@(negedge clk)
if((cnt>=cnt1)&(cnt1+22'h59>=cnt)&crl)
cl=1;
else cl=0;
always@(negedge clk)
if (cl)
led<=~led;
else led<=2'b00;
endmodule