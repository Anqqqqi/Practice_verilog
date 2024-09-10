module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    
    parameter A = 1'b0, B = 1'b1;
    reg	        current_state;
    reg	        next_state;
    
    always@(posedge clk)begin
        if(reset)begin
            current_state <= A;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@(*)begin
        case(current_state)
            A:begin
                next_state = s ? B : A;
            end
            B:begin
                next_state = B;
            end
        endcase
    end
 
    reg	[2:0]w_reg;

    always@(posedge clk)begin
        if(reset)begin
            w_reg <= 1'b0; 
        end
        else if(current_state == B)begin
            w_reg <= {w,w_reg[1:0]};
        end
        else if(counter > 1'd2)begin
         	w_reg <= 1'b0;
       	end
        else begin
            w_reg <= 1'b0;

        end
    end  
    
    always@(posedge clk)begin
        if(reset)begin
            z <= 1'b0;
        end
        else if(current_state == B && counter == 2'd0)begin
            if(w_reg == 3'b011 | w_reg == 3'b110 | w_reg == 3'b101)begin
                z <= 1'b1;
            end
            else begin
                z <= 1'b0;
            end
        end
        else begin
            z <= 1'b0;
        end
    end   
    
    reg [1:0]	counter;
    always@(posedge clk)begin
        if(reset)begin
            counter <= 2'd0;
        end
        else if(counter == 2'd2)begin
            counter <= 2'd0;
        end
        else if(next_state == B)begin
            counter <= counter + 1'b1;
        end
    end
    
endmodule
/// 90 mismatch