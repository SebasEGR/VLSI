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
    "0000011" when "0000", -- B
    "1000001" when "0001", -- U
    "0000110" when "0010", -- E
    "1001000" when "0011", -- n
    "1111111" when "0100", -- Espacio
    "0100001" when "0101", -- d
    "1111001" when "0110", -- I
    "0001000" when "0111", -- A
	 "1111111" when "1000", -- Espacio
    "1111111" when others;
end architecture;