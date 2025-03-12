library ieee;
use ieee.std_logic_1164.all;

entity concu1 is
port(clk: in std_logic;
	  ssg: out std_logic_vector(6 downto 0));
end entity;


architecture a of concu1 is
signal clkl: std_logic:='0';
signal contador: integer range 0 to 25000000:=0;	
signal conteo: integer:=0;



begin

--divisor de frecuencias
	
	process(clk)
	begin
			if(rising_edge(clk)) then
				if(contador=25000000) then
					contador<=0;
					clkl<= not clkl; --salida
				else
					contador<= contador+1;
				end if;
			end if;
	end process;
	
	
	--Counter
	process(clkl)
	begin
		if(rising_edge(clkl)) then
				if(conteo=9) then
					conteo<=0;
				else
					conteo<= conteo+1;
				end if;
		end if;
	end process;
	
--fin cont--
	with conteo select
	ssg<= "1000000" when 0,
	 "1111001" when 1,
	 "0100100" when 2,
	 "0110000" when 3,
	 "0011001" when 4,
	 "0010010" when 5,
	 "0000010" when 6,
	 "1111000" when 7,
	 "0000000" when 8,
	 "0011000" when 9,
	 "1111111" when others;
end architecture;