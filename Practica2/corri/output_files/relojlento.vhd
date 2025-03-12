library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

entity relojlento is
port
	(
	clkl  : in std_logic; 
	led : buffer std_logic:='0' 
	);
end entity;

architecture a of relojlento is
signal contador : integer range 0 to 25000000; --Se declara una señal que contará desde 0 hasta 25000000.

begin
	process (clkl)
		begin
			if (clkl' event and clkl='1') then --ta un flanco de subida en el reloj de la tarjeta, se procede a la condicional siguiente.
				if (contador = 25000000) then --Si el contador llega a 25000000, se regresa a 0 y se invierte el valor de clkl.
					contador <= 0;
					led     <= not (led);
				else
					contador <= contador + 1; --Cada flanco de subida se le suma uno al contador.
				end if;
			end if;
	end process;
end architecture;
