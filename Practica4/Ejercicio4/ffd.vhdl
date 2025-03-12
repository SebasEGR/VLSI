library ieee;
use ieee.std_logic_1164.all;

-- Definición de la entidad 'ffd' (Flip-Flop D)
entity ffd is
  port (
    clk : in std_logic;  -- Entrada de reloj (clk) para la sincronización
    q   : out integer;   -- Salida 'q' que toma el valor de 'd' en el flanco ascendente de clk
    d   : in integer     -- Entrada 'd' que será almacenada en 'q' en el flanco ascendente del reloj
  );
end entity;

-- Descripción de la arquitectura 'archffd' que define el comportamiento del flip-flop
architecture archffd of ffd is
begin
  -- Proceso que se ejecuta en cada flanco ascendente del reloj (clk)
  process (clk)
  begin
    if (rising_edge(clk)) then    -- Detecta el flanco ascendente de la señal 'clk'
      q <= d;                     -- Asigna el valor de 'd' a la salida 'q'
    end if;
  end process;
end architecture;
