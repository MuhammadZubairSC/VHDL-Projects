library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Four_bit_Binary_to_Two_bit_Decimal is
port(
		SW:	in std_logic_vector(3 downto 0);
	
		-- The MSB of HEX is the anode therefore they are 8 intead of 7
		-- Here the pin are active low as mentioned in the datasheet
		
	   HEX1: inout std_logic_vector(7 downto 0);
	   HEX0: inout std_logic_vector(7 downto 0)
);
end entity;

architecture rtl of Four_bit_Binary_to_Two_bit_Decimal is

	signal V	: std_logic_vector(3 downto 0);
	signal D0	: integer range 0 to 15;
	signal D1	: integer range 0 to 15;
	signal A	: integer range 0 to 15;
	signal z 	: std_logic := '0';
	
begin

	V <= SW;
	-- process for converting 4-bit binary to 2-bit decimal
	process(V) is
	begin
		A <= to_integer(unsigned(V));
		
	end process;
	
	process(A) is 
	begin
	
		if A > 9 then
			z <= '1';
			D0 <= A - 10;
			D1 <= 1;
			HEX1 <= "11111001";
		else
			z <= '0';
			D0 <= A;
			D1 <= 0;
			HEX1 <= "11000000";
		end if;
	end process;
	
	process(V) is
	begin
		
		case V is
			when "0000" => HEX0 <= "11000000"; -- 0
			when "0001" => HEX0 <= "11111001"; -- 1
			when "0010" => HEX0 <= "10100100"; -- 2
			when "0011" => HEX0 <= "10110000"; -- 3
			when "0100" => HEX0 <= "10011001"; -- 4
			when "0101" => HEX0 <= "10010010"; -- 5
			when "0110" => HEX0 <= "10000010"; -- 6
			when "0111" => HEX0 <= "11111000"; -- 7
			when "1000" => HEX0 <= "10000000"; -- 8
			when "1001" => HEX0 <= "10010000"; -- 9
			when "1010" => HEX0 <= "11000000"; -- 0
			when "1011" => HEX0 <= "11111001"; -- 1
			when "1100" => HEX0 <= "10100100"; -- 2
			when "1101" => HEX0 <= "10110000"; -- 3
			when "1110" => HEX0 <= "10011001"; -- 4
			when "1111" => HEX0 <= "10010010"; -- 5
			when others => 
				HEX0 <= HEX0;
			end case;
			
	end process;
		
end architecture;