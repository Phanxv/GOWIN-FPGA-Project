module leg4_rom (
	input  logic [3:0] address,
	output logic [7:0] out
) ;
	function [7:0] rom ;
		input [3:0] address ;
		begin
			case (address)
			4'h0: rom = 8'h20 ;
			4'h1: rom = 8'h08 ;
			4'h2: rom = 8'hE8 ;
			4'h3: rom = 8'hB1 ;
			4'h4: rom = 8'hB2 ;
			4'h5: rom = 8'hB4 ;
			4'h6: rom = 8'hB8 ;
			4'h7: rom = 8'hF0 ;
			4'h8: rom = 8'hB8 ;
			4'h9: rom = 8'hB4 ;
			4'hA: rom = 8'hB2 ;
			4'hB: rom = 8'hB1 ;
			4'hC: rom = 8'hF0 ;
			default: rom = 8'h00 ;
			endcase
		end
	endfunction : rom

	assign out = rom(address) ;

endmodule : leg4_rom
