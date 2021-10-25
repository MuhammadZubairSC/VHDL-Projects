library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity TrafficLightSignal is
generic (ClockFreq : integer := 50000000);
port(
	clk			: in std_logic;
	nrst		   : in std_logic; -- Neative reset means On at 0 zero
	NorthRed	   : out std_logic;
	NorthYellow	: out std_logic;
	NorthGreen	: out std_logic;
	WestRed		: out std_logic;
	WestYellow	: out std_logic;
	WestGreen	: out std_logic
	);  
	
end entity;
	

architecture rtl of TrafficLightSignal is

	-- Enumerate type declaration and state signal declaration
	type t_states is (NorthNext, StartNorth, North, StopNorth, WestNext, StartWest, 
					 West, StopWest);	
	signal State			: t_states;
	
	-- Counter for counting clock period; 1 min max
	signal counter_sig		: integer range 0 to ClockFreq * 60;

begin

	-- Initiating the process at the rising edge of the clock
	process(clk) is 
	
	-- Making a procedure to change the state and count 
	procedure ChangeState( T_State  : t_states;
						   minute	: integer :=0;
						   second	: integer :=0) is
		variable TotalTimeCycle : integer;
	begin
		TotalTimeCycle := (second + 60 * minute) * ClockFreq - 1;
		if counter_sig = TotalTimeCycle then
			counter_sig <= 0;
			State <= T_State;
		end if;
	end procedure;
	
	begin
		if rising_edge(clk) then
			if nrst = '0' then
			
				counter_sig <= 0;
				NorthRed	<= '1';
			    NorthYellow	<= '0';
			    NorthGreen	<= '0';
			    WestRed		<= '1';
		        WestYellow	<= '0';
		        WestGreen	<= '0';
		
				State <= NorthNext;
			else
				NorthRed	<= '0';
			    NorthYellow	<= '0';
			    NorthGreen	<= '0';
			    WestRed		<= '0';
		        WestYellow	<= '0';
		        WestGreen	<= '0';
				
				counter_sig <= counter_sig + 1;
				
				case State is 
					when NorthNext 	=>
						NorthRed	<= '1';  -- As signal only stores its last defined state
						WestRed		<= '1';
						-- If 5 seconds had passed
						ChangeState(StartNorth, second => 5);
						
					when StartNorth =>
						NorthRed	<= '1';
						NorthYellow	<= '1';
						WestRed		<= '1';
						-- If 5 seconds had passed
						ChangeState(North, second => 5);
						
					when North 		=>
						NorthGreen	<= '1';
						WestRed		<= '1';
						-- If I minute had passed
						ChangeState(StopNorth, minute => 1);
						
					when StopNorth 	=>
						NorthYellow	<= '1';
						WestRed		<= '1';
						-- If 5 seconds had passed
						ChangeState(WestNext, second => 5);
						
					when WestNext 	=>
						WestRed		<= '1';
						NorthRed	<= '1';
						-- If 5 seconds had passed
						ChangeState(StartWest, second => 5);
						
					when StartWest 	=>
						WestRed		<= '1';
						WestYellow	<= '1';
						NorthRed	<= '1';
						-- If 5 seconds had passed
						ChangeState(West, second => 5);
						
					when West 		=>
						WestGreen	<= '1';
						NorthRed	<= '1';
						-- If 1 minute had passed
						ChangeState(StopWest, minute => 1);
						
					when StopWest 	=>
						WestYellow	<= '1';
						NorthRed	<= '1';
						--If 5 seconds had passed
						ChangeState(NorthNext, second => 5);
						
				end case;
				
			end if;
			
		end if;
	end process;

end architecture;