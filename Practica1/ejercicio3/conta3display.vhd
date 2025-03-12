library ieee;
use ieee.std_logic_1164.all;

entity conta3display is
port(clk:in std_logic;
		ssg2: out std_logic_vector(6 downto 0);
		ssg3: out std_logic_vector(6 downto 0);
		ssg4: out std_logic_vector(6 downto 0);
		banderasalxd:out std_logic);
end entity;

architecture b of conta3display is
signal bandera1: std_logic;
signal conteo2: integer range 0 to 9;
begin
	u7: entity work.conta2display(a) port map(clk, ssg2, ssg3, bandera1);
	u8: entity work.cont(arqcont) port map(bandera1, conteo2, banderasalxd);
	u9: entity work.ss7(arqss7) port map(conteo2, ssg4);
end architecture;