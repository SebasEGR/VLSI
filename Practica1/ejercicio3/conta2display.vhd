library ieee;
use ieee.std_logic_1164.all;

entity conta2display is
port(clk:in std_logic;
		ssg0: out std_logic_vector(6 downto 0);
		ssg1: out std_logic_vector(6 downto 0);
		banderasal:out std_logic;
		banderasalxp:out std_logic);
end entity;

architecture a of conta2display is
signal bandera: std_logic;
signal conteo: integer range 0 to 9;
begin
	u4: entity work.contador(arqcontador) port map(clk, ssg0, bandera);
	u5: entity work.cont(arqcont) port map(bandera, conteo, banderaSal);
	u6: entity work.ss7(arqss7) port map(conteo, ssg1);
end architecture;