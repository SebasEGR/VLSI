library ieee;                         -- Se incluye la librería IEEE que contiene los tipos estándar para señales.
use ieee.std_logic_1164.all;           -- Se utiliza la librería de lógica estándar 1164 para definir señales como `std_logic`.

-- Declaración de la entidad `main`, que tiene varios puertos de entrada y salida.
entity main is
  port (
    clk, reset                   : in std_logic;          -- Se definen las señales de entrada `clk` (reloj) y `reset`.
    hex0, hex1, hex2, hex3, hex4 : buffer std_logic_vector(6 downto 0)  -- Se definen los puertos de salida `hex0` a `hex4`, que están conectados a displays de 7 segmentos.
  );
end entity;

-- La arquitectura `arqmain` describe el funcionamiento interno de la entidad `main`.
architecture arqmain of main is
  -- Se definen las señales internas de la arquitectura.
  signal clkl : std_logic;                                -- Señal de reloj lento `clkl` que se generará a partir del reloj de entrada `clk`.
  signal bcd  : std_logic_vector(3 downto 0) := "0000";   -- Señal `bcd` que será un vector de 4 bits, usado para la representación de números en formato BCD.
begin
  -- Se instancian las entidades dentro de la arquitectura principal (`main`).
  
  -- `u1` es una instancia del bloque `divfreq` que genera una señal de reloj lento `clkl` a partir del reloj de entrada `clk`.
  u1 : entity work.divfreq(rtl) port map(clk, clkl);   
  
  -- `u2` es una instancia del bloque `conta` que recibe el reloj lento `clkl` y el `reset`, y genera el contador BCD (`bcd`).
  u2 : entity work.conta(arqconta) port map(clkl, reset, bcd);
  
  -- `u3` es una instancia del bloque `ss7` que convierte la señal BCD en una representación en formato de 7 segmentos y la asigna a `hex0`.
  u3 : entity work.ss7(arqss7) port map(bcd, hex0);
  
  -- `u4`, `u5`, `u6` y `u7` son instancias de la entidad `display` que toman el reloj lento `clkl` y asignan la salida `hex0` a `hex4` en 4 displays de 7 segmentos diferentes.
  u4 : entity work.display(arqdisp) port map(clkl, hex0, hex1);
  u5 : entity work.display(arqdisp) port map(clkl, hex1, hex2);
  u6 : entity work.display(arqdisp) port map(clkl, hex2, hex3);
  u7 : entity work.display(arqdisp) port map(clkl, hex3, hex4);

end architecture;
