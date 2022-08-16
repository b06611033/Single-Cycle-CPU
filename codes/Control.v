module Control
(
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o,
    Op_i
);

input  [6:0]   Op_i;
output ALUSrc_o;
output [1:0]   ALUOp_o;
output RegWrite_o;



    

/*if (Op_i == 7'b0010011) 
    assign ALUSrc_o = 1; 

else 
    assign ALUSrc_o = 0;
  
  
assign RegWrite_o = 1;

if (Op_i == 7'b0010011) 
    assign ALUOp_o = 2'b10;       //R type
    
else 
    assign ALUOp_o = 2'b00;     //immediate type*/

assign ALUSrc_o = (Op_i == 7'b0010011) ? 1:0;
assign RegWrite_o = 1;
assign ALUOp_o = (Op_i == 7'b0010011) ? 2'b10: 2'b00;    //b10 is immediate type
    
    
   

endmodule




