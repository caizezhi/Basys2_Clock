`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:55:44 07/31/2015 
// Design Name: 
// Module Name:    adjust 
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
module adjust(clk,ad,switch,adj,cnt1); //闹钟里面的定时模块
input switch,ad,clk;
input [3:0] adj;
output [23:0] cnt1;
reg [23:0] cnt1;
always@(posedge clk)
if(switch==0&ad==1)
case(adj)
4'b0001:begin if(cnt1[11:8]==4'd9) cnt1[11:8]<=4'd0; else cnt1[11:8]<=cnt1[11:8]+1'd1;end 4'b0010:begin if(cnt1[15:12]==4'd5) cnt1[15:12]<=4'd0; else cnt1[15:12]<=cnt1[15:12]+1'd1;end

4'b0100:begin if(cnt1[19:16]==4'd9) cnt1[19:16]<=4'd0; else cnt1[19:16]<=cnt1[19:16]+1'd1;end 4'b1000:begin if(cnt1[23:20]==4'd2) cnt1[23:20]<=4'd0; else cnt1[23:20]<=cnt1[23:20]+1'd1;end default cnt1<=cnt1;
endcase
else if(switch==1&ad==1) case(adj)
4'b0001:begin if(cnt1[3:0]==4'd9) cnt1[3:0]<=4'd0; else cnt1[3:0]<=cnt1[3:0]+1'd1;end 4'b0010:begin if(cnt1[7:4]==4'd5) cnt1[7:4]<=4'd0; else cnt1[7:4]<=cnt1[7:4]+1'd1;end

4'b0100:begin if(cnt1[11:8]==4'd9) cnt1[11:8]<=4'd0; else cnt1[11:8]<=cnt1[11:8]+1'd1;end 4'b1000:begin if(cnt1[15:12]==4'd5) cnt1[15:12]<=4'd0; else cnt1[15:12]<=cnt1[15:12]+1'd1;end
default cnt1<=cnt1;
endcase
else cnt1<=cnt1;
endmodule