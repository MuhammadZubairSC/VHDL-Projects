library ieee;
use ieee.std_logic_1164.all;

entity Four_bit_Binary_to_Two_bit_Decimal_tb is
end entity;

architecture rtl of Four_bit_Binary_to_Two_bit_Decimal_tb is

	signal SW	: std_logic_vector(3 downto 0);
	signal HEX0	: std_logic_vector(7 downto 0);
	signal HEX1	: std_logic_vector(7 downto 0);
	
begin
	-- The Device Under Text (DUT)
	I_7Seg : entity work.Four_bit_Binary_to_Two_bit_Decimal(rtl)
	port map(
		SW 	 => SW,
		HEX0 => HEX0,
		HEX1 => HEX1
		);
	
	process
	begin
		report "*** Simulation Starting ***";
		wait for 10 ns;
		SW <= "0000";
		report "HEX1 0";
		wait for 10 ns;
		SW <= "1000";
		report "HEX1 0 and HEX0 8";
		wait for 10 ns;
		SW <= (others => '1');
		report "HEX1 1 and HEX0 5"; 
		wait for 10 ns;
		SW <= (others => '0');
		report "HEX1 0 and HEX0 0";
		wait;
	end process;
	
end architecture;