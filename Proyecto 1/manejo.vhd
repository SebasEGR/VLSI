library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity manejo is
port (contador: in integer;
		dig1, dig2: out integer);
end entity manejo;

architecture arqmanejo of manejo is
begin
process(contador)
variable contador_real: real := 0.0;
variable salida_real: real := 0.0;
begin

	if(contador > 5824) then
	
		dig1 <= 0;
		dig2 <= 0;

	else
		
		contador_real := real(contador);
		
		salida_real := (0.034*contador_real)/2.0;
		
		dig1 <= 1;
		dig2 <= 1;
		
		
		
		
	end if;
	
end process;

end architecture arqmanejo;