library ieee;
use ieee.std_logic_1164.all;

entity pwm is
  port (
    clk, reset : in std_logic;
    led        : out std_logic_vector(8 downto 0));
end entity;

architecture arqpwm of pwm is
  signal clk_led, clkl                                        : std_logic;
  signal led0, led1, led2, led3, led4, led5, led6, led7, led8 : integer;

begin
  -- Divisor de frecuencias para ffd y flip flops d para cada uno de los leds
  dvfff : entity work.divf(arqdivf) generic map (25000000) port map(clk, clkl);
  ld0   : entity work.data(arqdata) port map(clkl, reset, led0);
  ld1 : entity work.ffd(archffd) port map(clkl, led1, led0);
  ld2 : entity work.ffd(archffd) port map(clkl, led2, led1);
  ld3 : entity work.ffd(archffd) port map(clkl, led3, led2);
  ld4 : entity work.ffd(archffd) port map(clkl, led4, led3);
  ld5 : entity work.ffd(archffd) port map(clkl, led5, led4);
  ld6 : entity work.ffd(archffd) port map(clkl, led6, led5);
  ld7 : entity work.ffd(archffd) port map(clkl, led7, led6);
  ld8 : entity work.ffd(archffd) port map(clkl, led8, led7);

  -- Divisor de frecuencias para el pwm y los pwm de cada led, estos tomarán
  -- la entrada del anterior cada que los flip flop d transfieran el dato almacenado.
  dvfl : entity work.divf(arqdivf) generic map(250) port map(clk, clk_led);
  l0   : entity work.senal (arqsenal) port map(clk_led, led0, led(0));
  l1   : entity work.senal (arqsenal) port map(clk_led, led1, led(1));
  l2   : entity work.senal (arqsenal) port map(clk_led, led2, led(2));
  l3   : entity work.senal (arqsenal) port map(clk_led, led3, led(3));
  l4   : entity work.senal (arqsenal) port map(clk_led, led4, led(4));
  l5   : entity work.senal (arqsenal) port map(clk_led, led5, led(5));
  l6   : entity work.senal (arqsenal) port map(clk_led, led6, led(6));
  l7   : entity work.senal (arqsenal) port map(clk_led, led7, led(7));
  l8   : entity work.senal (arqsenal) port map(clk_led, led8, led(8));
end architecture;