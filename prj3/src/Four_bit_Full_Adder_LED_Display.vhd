library ieee;
use ieee.std_logic_1164.all;

entity Four_bit_Full_Adder_LED_Display is
port(
		-- Switch input for Cin, A and B
	   SW	: in std_logic_vector(8 downto 0);
		-- LED output for cout and Sout
	   LEDR	: out std_logic_vector(4 downto 0)
);
end entity;

architecture rtl of Four_bit_Full_Adder_LED_Display is

	signal A	: std_logic_vector(3 downto 0):= (others => '0');
	signal B	: std_logic_vector(3 downto 0):= (others => '0');
	signal Cin	: std_logic := '0';
	signal Sout	: std_logic_vector(3 downto 0);
	signal Cout	: std_logic;
	
	signal temp1, temp2, temp3 : std_logic;
	
	component fullAdder  is 
	port (
			a,b,cin 	: in std_logic;
			sout,cout	: out std_logic
			);
	end component;
	
begin

	A 			        <=	SW(7 downto 4);
	B 			        <=	SW(3 downto 0);
	Cin 		        <=	SW(8);
	-- Port maping
	F0:fullAdder port map(a=>A(0), b=>B(0), cin=>Cin,   cout=>temp1, sout => Sout(0));
	F1:fullAdder port map(a=>A(1), b=>B(1), cin=>temp1, cout=>temp2, sout => Sout(1));
	F2:fullAdder port map(a=>A(2), b=>B(2), cin=>temp2, cout=>temp3, sout => Sout(2));
	F3:fullAdder port map(a=>A(3), b=>B(3), cin=>temp3, cout=>Cout , sout => Sout(3));

	LEDR(4)		        <=	Cout;
	LEDR(3 downto 0)	<=	Sout;
		
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity fullAdder is
port(
		a,b,cin 	: in std_logic;
		sout,cout	: out std_logic
);
end entity;

architecture full_adder_rtl of fullAdder is
begin
	sout <= a xor b xor cin;
	cout <= (a and b) or (cin and (a or b));
		
end architecture;