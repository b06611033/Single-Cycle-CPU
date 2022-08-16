module Sign_Extend (
    data_i,
    funct3_i,
    data_o
);

input  [11:0]  data_i;
input  [2:0]  funct3_i;
output [31:0]  data_o;

/*if (funct3_i == 3'b101) 
    assign data_o = { {27{data_i[4]}}, data_i[4:0] };    //srai 5bit extend
    
else if (funct3_i == 3'b000) 
    assign data_o = { {20{data_i[11]}}, data_i };   // addi 12bit extend*/


assign data_o = (funct3_i == 3'b101) ? { {27{data_i[4]}}, data_i[4:0] }: { {20{data_i[11]}}, data_i };
    
 

endmodule