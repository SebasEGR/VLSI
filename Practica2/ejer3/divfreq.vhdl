library ieee;
use ieee.std_logic_1164.all;

-- Declaración de la entidad divfreq
entity divfreq is
  port
  (
    clk  : in std_logic;        -- Entrada de la señal de reloj (clk) de alta frecuencia
    clkl : buffer std_logic     -- Salida de la señal de reloj reducido (clkl) con frecuencia más baja
  );
end entity;

-- Descripción de la arquitectura del divisor de frecuencia (rtl)
architecture rtl of divfreq is
  -- Declaración de una señal interna que lleva el contador que se utiliza para dividir la frecuencia
  signal contador : integer range 0 to 25000000;  -- El contador irá desde 0 hasta 25,000,000
begin
  -- Proceso que se ejecuta en cada flanco ascendente de la señal clk
  process (clk)
  begin
    if (rising_edge(clk)) then    -- Se ejecuta en el flanco ascendente de la señal clk
        -- Cuando el contador alcanza el valor 25,000,000 (secuencia de 25 millones de ciclos)
        if (contador = 25000000) then
          contador <= 0;          -- Reinicia el contador a 0 cuando llega a 25,000,000
          clkl     <= not clkl;   -- Invertir el valor de clkl, generando una señal de baja frecuencia
        else
          contador <= contador + 1;  -- Si no ha llegado al valor límite, incrementar el contador
        end if;
    end if;
  end process;
end architecture;
