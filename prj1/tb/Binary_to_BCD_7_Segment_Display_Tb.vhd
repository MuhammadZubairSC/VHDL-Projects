library ieee;
use ieee.std_logic_1164.all;

entity Binary_to_BCD_7_Segment_Display_Tb is
end entity;

architecture rtl of Binary_to_BCD_7_Segment_Display_Tb is

	signal SW	: std_logic_vector(7 downto 0);
	signal HEX0	: std_logic_vector(7 downto 0);
	signal HEX1	: std_logic_vector(7 downto 0);
	
begin
	-- The Device Under Text (DUT)
	I_7Seg : entity work.Binary_to_BCD_7_Segment_Display(rtl)
	port map(
		SW 	 => SW,
		HEX0 => HEX0,
		HEX1 => HEX1
		);
	
	process
	begin
		report "*** Simulation Starting ***";
		wait for 10 ns;
		SW <= "10000000";
		report "HEX1 8";
		wait for 10 ns;
		SW <= "----1000";
		report "HEX1 8 and HEX0 8";
		wait for 10 ns;
		SW <= (others => '0');
		report "HEX1 0 and HEX0"; 
		wait for 10 ns;
		SW <= (others => '1');
		report "HEX1 0 and HEX0 0";
		wait;
	end process;
	
end architecture;