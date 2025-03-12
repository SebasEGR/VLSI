library ieee;
use ieee.std_logic_1164.all;

entity sensor is 
port (clk,rst, echo: in std_logic;
		trig, led, led2: out std_logic;
		ss0, ss1, ss2: out std_logic_vector(6 downto 0));
end entity;

architecture arqsensor of sensor is
signal clk1, clk2, tr: std_logic;
signal ss0_s, ss1_s, ss2_s: std_logic_vector(3 downto 0);
begin 
	u1: entity work.divf(arqdivf) generic map(25) port map(clk,clk1);
	u2: entity work.senal(arqsenal) port map(clk,clk2);
	u3: entity work.trigger(arqtrigger) port map(clk2,rst,echo,tr);
	trig<=tr;
	u4: entity work.contador(arqcontador) port map(echo,clk1,tr,led,led2,ss0_s,ss1_s,ss2_s);
	u5: entity work.ss7(arqss7) port map(ss0_s,ss0);
	u6: entity work.ss7(arqss7) port map(ss1_s,ss1);
	u7: entity work.ss7(arqss7) port map(ss2_s,ss2);
end architecture;
