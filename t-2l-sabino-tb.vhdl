library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Entity Definition
entity sabino_pa_tb is
	constant MAX_COMB: integer := 16;
	constant DELAY: time := 10 ns;
end entity sabino_pa_tb;

architecture sabino_pa_tb of sabino_pa_tb is
	signal in_buzzer: std_logic_vector(2 downto 0);
	signal out_buzzer: std_logic_vector(2 downto 0);
	signal alarm_set: std_logic; 
	
	component alarm is
	--port
	port(
		in_buzzer: in std_logic_vector(2 downto 0); -- three in_buzzers
		out_buzzer: in std_logic_vector(2 downto 0); -- three out_buzzers	
		alarm_set: out std_logic --alarm is set or not
	);
	end component alarm;

begin
	uut: component alarm port map(in_buzzer, out_buzzer, alarm_set);
	main: process is
		
		variable temp: unsigned(5 downto 0);
		variable expected: std_logic;
		variable error_count: integer := 0;
		
	begin
		report "Start Simulation";
		
		for i in 0 to 63 loop
			temp := TO_UNSIGNED(i, 6);
			--assign each input a value from temp
		in_buzzer(0) <= temp(0);
		in_buzzer(1) <= temp(1);
		in_buzzer(2) <= temp(2);
		out_buzzer(0) <= temp(3);
		out_buzzer(1) <= temp(4);
		out_buzzer(2) <= temp(5);
		
		wait for DELAY;
		-- (in || in || in) && (out || out || out)
		expected := ( (in_buzzer(0) or in_buzzer(1) or in_buzzer(2)) and (out_buzzer(0) or out_buzzer(1) or out_buzzer(2)) );
		
		assert(expected = alarm_set)
			report "ERROR: Expected("&
			std_logic'image(expected) &
			") /= (" & ")at time" & time'image(now);
		
			if(expected /= alarm_set) then
				error_count := error_count + 1;
			end if;
		
		end loop;
		wait for DELAY;
		assert (error_count = 0)
			report "ERROR: There were/was" &
				integer'image(error_count) & "error/s!";
			if(error_count = 0)
				then report "Simulation completed with no errors";
			end if;
		wait for DELAY;
	end process;
end architecture sabino_pa_tb;
		
		
