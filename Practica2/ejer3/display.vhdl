library ieee;                         -- Se incluye la librería IEEE para usar los tipos estándar como `std_logic`.
use ieee.std_logic_1164.all;           -- Se importa el paquete `std_logic_1164`, que contiene la definición de tipos como `std_logic` y `std_logic_vector`.

-- Declaración de la entidad `display`. Esta entidad tiene dos puertos de entrada y salida.
entity display is
  port (
    clk : in std_logic;                     -- `clk`: Señal de entrada tipo `std_logic` que representa el reloj de la FPGA.
    mi  : in std_logic_vector(6 downto 0);   -- `mi`: Señal de entrada tipo `std_logic_vector(6 downto 0)` de 7 bits, que representa los datos de entrada (probablemente los segmentos de un display de 7 segmentos).
    mo  : out std_logic_vector(6 downto 0)   -- `mo`: Señal de salida tipo `std_logic_vector(6 downto 0)` de 7 bits, que representa los datos de salida (los segmentos que se deben mostrar en el display).
  );
end entity;

-- La arquitectura `arqdisp` describe cómo la entidad `display` funciona internamente.
architecture arqdisp of display is
begin
  -- El proceso `process(clk)` es sensible a la señal `clk`, es decir, se ejecuta cada vez que cambia el valor de `clk`.
  process (clk)
  begin
    -- Este bloque se ejecuta cuando se detecta un flanco ascendente en el reloj (`rising_edge(clk)`).
    -- Esto asegura que las señales se actualicen sincronizadas con el reloj.
    if rising_edge(clk) then
      -- En cada flanco ascendente del reloj, la señal de salida `mo` toma el valor de la señal de entrada `mi`.
      mo <= mi;
    end if;
  end process;
end architecture;
