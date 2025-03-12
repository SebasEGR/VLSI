library ieee;
use ieee.std_logic_1164.all;

entity pwm is
  port (
    clk : in std_logic;
    led : out std_logic_vector(8 downto 0));
end entity;

architecture arqpwm of pwm is
  signal clkl : std_logic;
begin
  ul : entity work.divf(arqdivf) generic map(250) port map(clk, clkl); 
  l0 : entity work.senal (arqsenal) port map(clkl, 1025, led(0));
  l1 : entity work.senal (arqsenal) port map(clkl, 516, led(1));
  l2 : entity work.senal (arqsenal) port map(clkl, 256, led(2));
  l3 : entity work.senal (arqsenal) port map(clkl, 128, led(3));
  l4 : entity work.senal (arqsenal) port map(clkl, 64, led(4));
  l5 : entity work.senal (arqsenal) port map(clkl, 32, led(5));
  l6 : entity work.senal (arqsenal) port map(clkl, 16, led(6));
  l7 : entity work.senal (arqsenal) port map(clkl, 8, led(7));
  l8 : entity work.senal (arqsenal) port map(clkl, 4, led(8));
end architecture;