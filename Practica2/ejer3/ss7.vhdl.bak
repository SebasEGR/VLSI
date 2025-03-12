library ieee;
use ieee.std_logic_1164.all;

entity ss7 is
  port (
    bcd : in std_logic_vector(3 downto 0);
    hex : out std_logic_vector(6 downto 0)
  );
end entity;

architecture arqss7 of ss7 is
begin
  with bcd select
    hex <=
    "0001001" when "0000", -- H
    "1000000" when "0001", -- O
    "1000111" when "0010", -- L
    "0001000" when "0011", -- A
    "1111111" when "0100", -- Espacio
    "0001100" when "0101", -- P
    "0101111" when "0110", -- r
    "1000000" when "0111", -- O
    "0001110" when "1000", -- F
    "0000110" when "1001", -- E
	 "1111111" when "1010", -- Espacio
    "1111111" when others;
end architecture;