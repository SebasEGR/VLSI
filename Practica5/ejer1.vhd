library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ejer1 is
port (clk,pi,pf,inc,dec,rst : in std_logic;
		 control : out std_logic);
end entity;

architecture Behavioral of ejer1 is
signal clkl: STD_LOGIC;

--Este valor determina la proporción de tiempo que la señal estará en nivel 
--alto durante un período. Ajustar este valor cambia la posición del servomotor[2]
signal duty : integer range 0 to 200:=85;
begin
   --Un divisor de frecuencia que genera una señal de reloj clkl más 
	--lenta a partir de la señal de entrada clk.
	u1: entity work.divf(arqdivf) generic map(500) port map (clk, clkl);
	
	--Genera la señal de control PWM para el servomotor según el valor de 
	--duty (ciclo de trabajo) y la señal de reloj clkl.
	u2: entity work.senal(arqsnl) port map (clkl, duty, control);
	
	--Ajusta el ciclo de trabajo (duty) en función de las señales de control pi, pf, inc, dec y rst, 
	--que indican posiciones y movimientos incrementales del servomotor. [2]
	u3: entity work.movimiento(arqmov) port map(clkl,pi,pf,inc,dec,rst,duty);
end architecture;