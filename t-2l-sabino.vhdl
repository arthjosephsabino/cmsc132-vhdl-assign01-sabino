--Library Statements
library IEEE;

use IEEE.std_logic_1164.all;

--Entity Definition
entity alarm is
--port
	port(
		in_buzzer: in std_logic_vector(2 downto 0); -- three in_buzzers
		out_buzzer: in std_logic_vector(2 downto 0); -- three out_buzzers	
		alarm_set: out std_logic --alarm is set or not
	);
end entity alarm;

--Architecture Definition
architecture behaviour of alarm is
begin
	process(in_buzzer(0), in_buzzer(1), in_buzzer(2), out_buzzer(0), out_buzzer(1), out_buzzer(2)) is
	begin
		--(in || in || in) and (out || out || out)
		if( ((in_buzzer(0) = '1') or (in_buzzer(1) = '1') or (in_buzzer(2) = '1')) and ((out_buzzer(0) = '1') or (out_buzzer(1) = '1') or (out_buzzer(2) = '1')))
			then alarm_set <= '1';
		else alarm_set <= '0';
		
		end if;
	end process;
end architecture behaviour;
